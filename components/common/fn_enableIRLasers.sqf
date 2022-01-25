#include "script_component.hpp"

params ["_group", "_enable"];

if (_enable) then {_group setBehaviour "COMBAT"};
{_x enableIRLasers _enable} forEach units _group;
