#include "script_component.hpp"

params ["_group", "_pos", ["_timeout", 0]];

private _wp = _group addWaypoint [_pos, 0];
_wp setWaypointTimeout [_timeout, _timeout, _timeout];
_wp setWaypointStatements ["true", format ["call %1", {
    if !(local this) exitWith {};
    private _group = group this;
    private _vehicles = [_group, true] call BIS_fnc_groupVehicles;
    {deleteVehicle _x} forEach (thisList + _vehicles);
}]];
