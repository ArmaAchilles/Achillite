#include "script_component.hpp"

(_this call BIS_fnc_spawnVehicle) params ["_vehicle", "", "_group"];
[_vehicle] call ACL_fnc_addObjects;
_group deleteGroupWhenEmpty true;
_vehicle // Return value
