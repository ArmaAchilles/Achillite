#include "script_component.hpp"

[
    "Inventory", "Add Full Arsenal",
    {
        private _box = [_this] call ACL_fnc_checkModuleTarget;
        if (isNil "_box") exitWith {};

        ["AmmoboxInit", [_box, true]] call BIS_fnc_arsenal;
        "ARSENAL ADDED" call ACL_fnc_showZeusMessage;
    }
] call ACL_fnc_registerModule
