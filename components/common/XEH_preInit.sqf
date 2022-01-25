#include "script_component.hpp"

ACL_fnc_addObjects = {
    [getAssignedCuratorLogic player, [_this, true]] remoteExecCall ["addCuratorEditableObjects", 2];
};

ACL_fnc_allowDamage = {
    _this remoteExecCall ["allowDamage", _this select 0];
};

ACL_fnc_removeObjects = {
    [getAssignedCuratorLogic player, [_this, true]] remoteExecCall ["removeCuratorEditableObjects", 2];
};



// Per frame handlers
// Similar to CBA functions, but different implementation and less comprehensive
ACL_execNextFrameQueue = [];
ACL_waitAndExecuteQueue = [];
ACL_waitUntilAndExecuteQueue = [];
ACL_fnc_addPerFrameHandlerQueue = createHashMap;

ACL_fnc_execNextFrame = {
    params ["_code", ["_args", []]];

    ACL_execNextFrameQueue pushBack [_code, _args, diag_frameNo + 1];
};

ACL_fnc_waitAndExecute = {
    params ["_code", ["_args", []], ["_delay", 0]];

    ACL_waitAndExecuteQueue pushBack [_code, _args, time + _delay];
};

ACL_fnc_waitUntilAndExecute = {
    params ["_cond", "_code", ["_args", []]];

    ACL_waitUntilAndExecuteQueue pushBack [_cond, _code, _args];
};

ACL_fnc_addPerFrameHandler = {
    params ["_code", ["_delay", 0], ["_args", []]];

    private _handle = selectMax keys ACL_fnc_addPerFrameHandlerQueue;
    _handle = if (isNil "_handle") then {0} else {_handle + 1};
    ACL_fnc_addPerFrameHandlerQueue set [_handle, [_code, _delay, _args, 0]];
    _handle // Return value
};

ACL_fnc_removePerFrameHandler = {
    params ["_handle"];

    ACL_fnc_addPerFrameHandlerQueue deleteAt _handle;
};

["ACL_onEachFrame", "onEachFrame", {
    for "_i" from (count ACL_execNextFrameQueue - 1) to 0 step -1 do {
        (ACL_execNextFrameQueue select _i) params ["_code", "_args", "_frame"];
        if (_frame <= diag_frameNo) then {
            _args call _code;
            ACL_execNextFrameQueue deleteAt _i
        };
    };

    for "_i" from (count ACL_waitAndExecuteQueue - 1) to 0 step -1 do {
        (ACL_waitAndExecuteQueue select _i) params ["_code", "_args", "_time"];
        if (_time <= time) then {
            _args call _code;
            ACL_waitAndExecuteQueue deleteAt _i
        };
    };

    for "_i" from (count ACL_waitUntilAndExecuteQueue - 1) to 0 step -1 do {
        (ACL_waitUntilAndExecuteQueue select _i) params ["_cond", "_code", "_args"];
        if (_args call _cond) then {
            _args call _code;
            ACL_waitUntilAndExecuteQueue deleteAt _i
        };
    };

    {
        _y params ["_code", "_delay", "_args", "_time"];
        if (_time <= time) then {
            _args call _code;
            _y set [3, time + _delay];
        };
    } forEach ACL_fnc_addPerFrameHandlerQueue;
}] call BIS_fnc_addStackedEventHandler
