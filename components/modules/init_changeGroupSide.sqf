#include "script_component.hpp"

[
    "Misc", "Change Group Side",
    {
        private _unit = [_this, ["AllVehicles"]] call ACL_fnc_checkModuleTarget;
        if (isNil "_unit") exitWith {};
        private _oldGroup = group _unit;

        ["Change Group Side", [
                [
                    "COMBO",
                    "New Side",
                    [0, SIDE_NAMES_TO_SELECT]
                ]
            ], {
                params ["_values", "_oldGroup"];
                _values params ["_sideIdx"];
                private _side = SIDES_TO_SELECT select _sideIdx;

                if (side _oldGroup isEqualTo _side) exitWith {};
                private _groupId = groupId _oldGroup;
                private _group = createGroup [_side, true];
                _group setGroupIdGlobal [_groupId];
                {
                    private _team = assignedTeam _x;
                    [_x] joinSilent _group;
                    _x assignTeam _team;
                } forEach units _oldGroup;
                deleteGroup _oldGroup;
            }, {}, _oldGroup
        ] call ACL_fnc_createDialog;
    }
] call ACL_fnc_registerModule
