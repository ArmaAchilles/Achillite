#include "script_component.hpp"

params ["_entity", "_prefix"];

format ["%1:%2", _prefix, _entity call BIS_fnc_netId] // Return value
