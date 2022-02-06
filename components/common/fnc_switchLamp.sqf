#include "script_component.hpp"

params ["_objects", "_switchOn"];
private _mode = ["OFF", "ON"] select _switchOn;

{
    private _jip = [_x, "ACL_switchLamp"] call ACL_fnc_jipId;
    [_x, _mode] remoteExecCall ["switchLight", 0, _jip];
} forEach _objects;
