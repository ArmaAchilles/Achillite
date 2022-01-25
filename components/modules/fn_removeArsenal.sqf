#include "script_component.hpp"

[
    "Inventory", "Remove Arsenal",
    {
        private _box = [_this] call ACL_fnc_checkModuleTarget;
        if (isNil "_box") exitWith {};

        // Set variables manually, since "AmmoboxExit" is not reliable
        _box setVariable ["BIS_addVirtualWeaponCargo_cargo", nil, true];
        private _boxes = missionNamespace getVariable ["BIS_fnc_arsenal_boxes", []];
        missionNamespace setVariable ["BIS_fnc_arsenal_boxes", _boxes - [_box], true];
        "ARSENAL REMOVED" call ACL_fnc_showZeusMessage;
    }
] call ACL_fnc_registerModule
