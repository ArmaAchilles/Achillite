#include "script_component.hpp"

params ["_vehicle", "_pos", ["_timeout", 0]];

private _wp = (group _vehicle) addWaypoint [_pos, 0];
_wp setWaypointTimeout [_timeout, _timeout, _timeout];
_wp setWaypointStatements ["true", "deleteVehicle vehicle this; {deleteVehicle _x} forEach thisList"];
