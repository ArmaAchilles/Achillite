#include "script_component.hpp"

[
    "Inventory", "Add Full Arsenal",
    {
        private _box = [_this] call ACL_fnc_checkModuleTarget;
        if (isNil "_box") exitWith {};

        // Restore loadout on respawn
        if (isNil "ACL_loadoutEnabled") then {
            [[], {
                [missionnamespace, "arsenalClosed", {
                    player setVariable ["ACL_loadout", getUnitLoadout player];
                    hint "Loadout saved for respawn!";
                }] call BIS_fnc_addScriptedEventHandler;

                player addEventHandler ["Respawn", {
                    private _loadout = player getVariable ["ACL_loadout", []];
                    if (_loadout isNotEqualTo []) then {
                        _loadout spawn {player setUnitLoadout _this};
                    };
                }];
            }] remoteExecCall ["call", 0, "ACL_loadout"];

            ACL_loadoutEnabled = true;
            publicVariable "ACL_loadoutEnabled";
        };

        ["AmmoboxInit", [_box, true]] call BIS_fnc_arsenal;
        "ARSENAL ADDED" call ACL_fnc_showZeusMessage;
    }
] call ACL_fnc_registerModule
