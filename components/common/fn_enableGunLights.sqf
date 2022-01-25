#include "script_component.hpp"

params ["_group", "_enable"];

_enable = ["ForceOff", "ForceOn"] select _enable;
{_x enableGunLights _enable} forEach units _group;
