#include "script_component.hpp"

params ["_aircraft", "_pos"];

private _passengerCount = {(assignedVehicleRole _x) param [0, ""] == "cargo"} count crew _aircraft;
private _pilot = driver _aircraft;

_pilot setSkill 1;
_pilot allowFleeing 0;

private _movePos = _pos getPos [1000, _aircraft getDir _pos];
_aircraft doMove _movePos;
[
    {
        params ["_aircraft", "_passengerCount", "_movePos"];
        !(alive _aircraft) || {(_movePos distance2D (getPos _aircraft)) - PARADROP_OFFSET_DISTANCE < (KMH_TO_MS(speed _aircraft) * EJECT_DELAY * _passengerCount / 2)}
    }, {
        params ["_aircraft"];
        if !(alive _aircraft) exitWith {};
        _aircraft call ACL_fnc_ejectPassengers;
    }, [_aircraft, _passengerCount, _movePos]
] call ACL_fnc_waitUntilAndExecute;
