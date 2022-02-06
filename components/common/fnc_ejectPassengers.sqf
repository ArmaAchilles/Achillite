#include "script_component.hpp"

params ["_vehicle"];
private _passengers = (crew _vehicle) select {alive _x && {(assignedVehicleRole _x param [0, ""]) == "cargo"}};

{
    [
        {
            [_this] orderGetIn false;
            unassignVehicle _this;
            if (getPos _this select 2 >= PARADROP_MIN_HEIGHT) then {
                moveOut _this;
                _this addBackpack PARADROP_CHUTE_CLASS;
                _this action ["OpenParachute"];
            } else {
                _this action ["Eject", vehicle _this];
            };
        }, _x, _forEachIndex * EJECT_DELAY
    ] call ACL_fnc_waitAndExecute;
} forEach _passengers;

if (getVehicleCargo _vehicle isNotEqualTo []) then {
    [
        {
            _this setVehicleCargo objNull;
        }, _vehicle, 0.5 * count _passengers * EJECT_DELAY
    ] call ACL_fnc_waitAndExecute;
};
