#include "script_component.hpp"

ACL_fnc_addObject = {
    [getAssignedCuratorLogic player, [_this, true]] remoteExecCall ["addCuratorEditableObjects", 2]
};

ACL_fnc_allowDamage = {
    _this remoteExecCall ["allowDamage", _this select 0];
};

ACL_fnc_enableFatigue = {
    if (isNil "ACL_fatigueEnabled") then {
        ACL_fatigueEnabled = _this;
        publicVariable "ACL_fatigueEnabled";
        [nil, {
            player enableFatigue ACL_fatigueEnabled;
            player addEventHandler ["respawn", {_this select 0 enableFatigue ACL_fatigueEnabled}];
        }] remoteExecCall ["call", 0, "ACL_enableFatigue"];
    } else {
        ACL_fatigueEnabled = _this;
        publicVariable "ACL_fatigueEnabled";
    }
};

ACL_fnc_removeObject = {
    [getAssignedCuratorLogic player, [_this, true]] remoteExecCall ["removeCuratorEditableObjects", 2]
};

ACL_fnc_setPlayerRespawnTime = {
    if (isNil "ACL_playerRespawnTime") then {
        ACL_playerRespawnTime = _this;
        publicVariable "ACL_playerRespawnTime";
        [nil, {
            player addEventHandler ["killed", {setPlayerRespawnTime ACL_playerRespawnTime}];
        }] remoteExecCall ["call", 0, "ACL_setPlayerRespawnTime"];
    } else {
        ACL_playerRespawnTime = _this;
        publicVariable "ACL_playerRespawnTime";
    }
};

ACL_fnc_setViewDistance = {
    params ["_distance", "_objectDistance"];
    _distance remoteExecCall ["setViewDistance", 0, "ACL_setViewDistance"];
    _objectDistance remoteExecCall ["setObjectViewDistance", 0, "ACL_setObjectViewDistance"]
};

if (isNil "ACL_waitUntilAndExecute_queue") then {
    ACL_waitUntilAndExecute_queue = []
};
ACL_fnc_waitUntilAndExecute = {ACL_waitUntilAndExecute_queue pushBack _this};
["ACL_onEachFrame", "onEachFrame", {
    for "_i" from (count ACL_waitUntilAndExecute_queue - 1) to 0 step -1 do {
        (ACL_waitUntilAndExecute_queue select _i) params ["_cond", "_code", ["_args", []]];
        if (_args call _cond) then {
            _args call _code;
            ACL_waitUntilAndExecute_queue deleteAt _i
        }
    }
}] call BIS_fnc_addStackedEventHandler
