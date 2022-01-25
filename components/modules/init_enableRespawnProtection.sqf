#include "script_component.hpp"

ACL_fnc_initializeProtection = {
    [
        {
            {
                private _player = _x;
                if (ACL_staticRespawns findIf {_x distance2D _player <= ACL_protectionRadius} >= 0) then {
                    if !(_player getVariable ["ACL_protected", false]) then {
                        [_player, true] call ACL_fnc_protectPlayer;
                        _player setVariable ["ACL_protected", true];
                    };
                } else {
                    if (_player getVariable ["ACL_protected", true]) then {
                        [_player, false] call ACL_fnc_protectPlayer;
                        _player setVariable ["ACL_protected", false];
                    };
                };
            } forEach allPlayers;
        },
        PROTECTION_HANDLER_DELAY
    ] call ACL_fnc_addPerFrameHandler;

    ACL_protectionInitialized = true;
};

[
    "Respawn", "Enable Protection",
    {
        private _enabled = missionNamespace getVariable ["ACL_fatigueEnabled", true];
        ["Enable Protection", [
                [
                    "EDIT",
                    "Radius of Protection [m]",
                    str (missionNamespace getVariable ["ACL_protectionRadius", 100]),
                    true
                ]
            ], {
                ACL_protectionRadius = parseNumber (_this select 0 select 0);
                ACL_staticRespawns = allMissionObjects "ModuleRespawnPositionWest_F";

                if (isNil "ACL_protectionInitialized") then {
                    [] call ACL_fnc_initializeProtection;
                };

                "PROTECTION ENABLED ON ALL CURRENT STATIC RESPAWNS" call ACL_fnc_showZeusMessage;
            }
        ] call ACL_fnc_createDialog;
    }
] call ACL_fnc_registerModule;
