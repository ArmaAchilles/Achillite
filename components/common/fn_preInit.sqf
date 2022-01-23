#include "script_component.hpp"

ACL_fnc_addObjects = {
    [getAssignedCuratorLogic player, [_this, true]] remoteExecCall ["addCuratorEditableObjects", 2]
};

ACL_fnc_allowDamage = {
    _this remoteExecCall ["allowDamage", _this select 0];
};

ACL_fnc_buildingPositions = {
    private _posList = (_this buildingPos -1) select {(_x nearEntities ["Man", 1]) isEqualTo []};
    _posList apply {
        _posASL = ATLToASL _x;
        // Fix building positions by searching the floor
        _intersections = lineIntersectsSurfaces [_posASL vectorAdd [0, 0, 0.1], _posASL vectorAdd [0, 0, -3]];
        _intersections select 0 select 0
    }
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

ACL_fnc_getGroupLogic = {
    if (isNil "ACL_groupLogic") then {
        ACL_groupLogic = createGroup sideLogic;
        ACL_groupLogic deleteGroupWhenEmpty false;
    };
    ACL_groupLogic // Return value
};

ACL_fnc_getPlayerRespawnTime = {
    if (isNil "ACL_playerRespawnTime") then {
        getNumber (missionConfigFile >> "respawnDelay") // Return value
    } else {
        ACL_playerRespawnTime // Return value
    }
};

ACL_fnc_isInsideBuilding =
{
    params ["_pos", "_building"];
    _pos = _pos vectorAdd [0, 0, EYE_HEIGHT];

    // if we have at least 3 walls and a roof, we are inside
    if (_building in (lineIntersectsObjs [_pos, _pos vectorAdd REL_REF_POS_VERTICAL])) then {
        {_building in (lineIntersectsObjs [_pos, _pos vectorAdd _x])} count REL_REF_POS_LIST_HORIZONTAL >= 3 // return value
    } else {
        false // return value
    }
};

ACL_fnc_removeObjects = {
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
    params ["_distance", "_objectDistance", "_shadowDistance"];
    _distance remoteExecCall ["setViewDistance", 0, "ACL_setViewDistance"];
    [[_objectDistance, _shadowDistance]] remoteExecCall ["setObjectViewDistance", 0, "ACL_setObjectViewDistance"]
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
