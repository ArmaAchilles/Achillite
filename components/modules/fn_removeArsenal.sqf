#include "script_component.hpp"

[
    "Inventory", "Remove Arsenal",
    {
        params ["", "_box"];
        // Set variables manually, since "AmmoboxExit" is not reliable
        _box setVariable ["BIS_addVirtualWeaponCargo_cargo", nil, true];
        private _boxes = missionNamespace getVariable ["BIS_fnc_arsenal_boxes", []];
        missionNamespace setVariable ["BIS_fnc_arsenal_boxes", _boxes - [_box], true];
    }
] call ACL_fnc_registerModule
