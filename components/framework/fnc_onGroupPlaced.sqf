#include "script_component.hpp"

params ["_curator", "_group"];

if !(isGroupDeletedWhenEmpty _group) then {
    _group deleteGroupWhenEmpty true;
};
