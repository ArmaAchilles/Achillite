#include "script_component.hpp"

ACL_ambientAnimList = [
    "STAND1",
    "STAND2",
    "STAND_U1",
    "STAND_U2",
    "STAND_U3",
    "WATCH",
    "WATCH2",
    "GUARD",
    "LISTEN_BRIEFING",
    "LEAN_ON_TABLE",
    "LEAN",
    "SIT_AT_TABLE",
    "SIT1",
    "SIT",
    "SIT3",
    "SIT_U1",
    "SIT_U2",
    "SIT_U3",
    "SIT_HIGH1",
    "SIT_HIGH",
    "SIT_LOW",
    "SIT_LOW_U",
    "SIT_SAD1",
    "SIT_SAD2",
    "KNEEL",
    "REPAIR_VEH_PRONE",
    "REPAIR_VEH_KNEEL",
    "REPAIR_VEH_STAND",
    "PRONE_INJURED_U1",
    "PRONE_INJURED_U2",
    "PRONE_INJURED",
    "KNEEL_TREAT",
    "KNEEL_TREAT2",
    "BRIEFING",
    "BRIEFING_POINT_LEFT",
    "BRIEFING_POINT_RIGHT",
    "BRIEFING_POINT_TABLE"
];

ACL_ambientAnimCombatList = [
    "STAND",
    "STAND_IA",
    "SIT_LOW",
    "KNEEL",
    "LEAN",
    "WATCH",
    "WATCH1",
    "WATCH2"
];

[
    "AI", "Ambient Animation",
    {
        private _unit = [_this, ["Man"], false] call ACL_fnc_checkModuleTarget;
        if (isNil "_unit") exitWith {};

        if ((_unit getVariable ["BIS_fnc_ambientAnim__animset", ""]) isNotEqualTo "") exitWith
        {
            _unit call BIS_fnc_ambientAnim__terminate;
            "ANIMATION TERMINATED" call ACL_fnc_showZeusMessage;
        };

        ["Ambient Animation", [
                ["COMBO", "Animation", [0, ACL_ambientAnimList]]
            ], {
                params ["_values", "_unit"];
                private _animID = (_values select 0);

                [_unit, ACL_ambientAnimList select _animID, "ASIS"] call BIS_fnc_ambientAnim;
            }, {}, _unit
        ] call ACL_fnc_createDialog;
    }
] call ACL_fnc_registerModule;

[
    "AI", "Ambient Animation (Combat)",
    {
        private _unit = [_this, ["Man"], false] call ACL_fnc_checkModuleTarget;
        if (isNil "_unit") exitWith {};

        if ((_unit getVariable ["BIS_fnc_ambientAnim__animset", ""]) isNotEqualTo "") exitWith
        {
            _unit call BIS_fnc_ambientAnim__terminate;
            "ANIMATION TERMINATED" call ACL_fnc_showZeusMessage;
        };

        ["Ambient Animation (Combat)", [
                ["COMBO", "Animation", [0, ACL_ambientAnimCombatList]]
            ], {
                params ["_values", "_unit"];
                private _animID = (_values select 0);

                [_unit, ACL_ambientAnimCombatList select _animID, "ASIS"] call BIS_fnc_ambientAnimCombat;
            }, {}, _unit
        ] call ACL_fnc_createDialog;
    }
] call ACL_fnc_registerModule;
