#include "script_component.hpp"

params ["_pos", "_building"];
_pos = _pos vectorAdd [0, 0, EYE_HEIGHT];

// if we have at least 3 walls and a roof, we are inside
if (_building in (lineIntersectsObjs [_pos, _pos vectorAdd REL_REF_POS_VERTICAL])) then {
    {_building in (lineIntersectsObjs [_pos, _pos vectorAdd _x])} count REL_REF_POS_LIST_HORIZONTAL >= 3 // return value
} else {
    false // return value
}
