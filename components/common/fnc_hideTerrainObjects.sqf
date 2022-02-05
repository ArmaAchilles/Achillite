#include "script_component.hpp"

params ["_center", "_types", "_radius", "_hide"];

{
    [_x, _hide] remoteExecCall ["hideObjectGlobal", 2];
} forEach nearestTerrainObjects [_center, _types, _radius, false, true];
