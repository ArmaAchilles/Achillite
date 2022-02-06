#include "script_component.hpp"

params ["_curator", "_object"];
curatorMouseOver params [["_type", ""], ["_entity", objNull]];
if (_type isEqualTo "OBJECT") then {
    // Handle vehicle cargo
    if (_entity canVehicleCargo _object select 0) exitWith {
        _entity setVehicleCargo _object;
    };
    if (isVehicleCargo _object isEqualTo _entity) exitWith {
        objNull setVehicleCargo _object;
    };
};
