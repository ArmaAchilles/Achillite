#include "script_component.hpp"

[
    "Misc", "Change Side Relations",
    {
        ["Change Side Relations", [
                [
                    "COMBO",
                    "Side",
                    [0, SIDE_NAMES_TO_SELECT]
                ],
                [
                    "TOOLBOX",
                    "Relation",
                    [0, ["Hostile", "Friendly"]]
                ],
                [
                    "COMBO",
                    "Side",
                    [2, SIDE_NAMES_TO_SELECT]
                ]
            ], {
                params ["_values", "_oldGroup"];
                _values params ["_sideIdx1", "_friendly", "_sideIdx2"];
                private _side1 = SIDES_TO_SELECT select _sideIdx1;
                private _side2 = SIDES_TO_SELECT select _sideIdx2;
                [_side1, _side2, _friendly] call ACL_fnc_setFriend;
            }
        ] call ACL_fnc_createDialog;
    }
] call ACL_fnc_registerModule
