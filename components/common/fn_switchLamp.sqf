#include "script_component.hpp"

[_this, {
    params ["_objects", "_switchOn"];
    {[_x, _switchOn] call BIS_fnc_switchLamp} forEach _objects;
}] remoteExecCall ["call", 0, "ACL_switchLamp"];
