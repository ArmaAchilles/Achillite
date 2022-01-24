#include "script_component.hpp"

private _posList = (_this buildingPos -1) select {(_x nearEntities ["Man", 1]) isEqualTo []};
_posList apply {
    _posASL = ATLToASL _x;
    // Fix building positions by searching the floor
    _intersections = lineIntersectsSurfaces [_posASL vectorAdd [0, 0, 0.1], _posASL vectorAdd [0, 0, -3]];
    _intersections select 0 select 0
} // Return value
