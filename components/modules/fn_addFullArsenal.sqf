#include "script_component.hpp"

[
    "Inventory", "Add Full Arsenal",
    {
        params ["", "_box"];
        ["AmmoboxInit", [_box, true]] call BIS_fnc_arsenal;
    }
] call ACL_fnc_registerModule
