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

ACL_waitAndExecute_queue = [];
ACL_waitUntilAndExecute_queue = [];
ACL_fnc_waitAndExecute = {
    _this set [2, time + (_this select 2)];
    ACL_waitAndExecute_queue pushBack _this;
};
ACL_fnc_waitUntilAndExecute = {ACL_waitUntilAndExecute_queue pushBack _this};
["ACL_onEachFrame", "onEachFrame", {
    for "_i" from (count ACL_waitAndExecute_queue - 1) to 0 step -1 do {
        (ACL_waitAndExecute_queue select _i) params ["_code", "_args", "_time"];
        if (_time >= time) then {
            _args call _code;
            ACL_waitAndExecute_queue deleteAt _i
        };
    };

    for "_i" from (count ACL_waitUntilAndExecute_queue - 1) to 0 step -1 do {
        (ACL_waitUntilAndExecute_queue select _i) params ["_cond", "_code", ["_args", []]];
        if (_args call _cond) then {
            _args call _code;
            ACL_waitUntilAndExecute_queue deleteAt _i
        };
    };
}] call BIS_fnc_addStackedEventHandler
