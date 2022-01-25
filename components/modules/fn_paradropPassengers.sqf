#include "script_component.hpp"

[
    "AI", "Paradrop Passengers",
    {
        private _aircraft = [_this, ["Helicopter", "Plane"], false] call ACL_fnc_checkModuleTarget;
        if (isNil "_aircraft") exitWith {};

        [[_aircraft], {
            params ["_confirmed", "_objects", "_pos"];
            if (_confirmed) then {
                _objects params ["_aircraft"];
                private _passengerCount = {(assignedVehicleRole _x) param [0, ""] == "cargo"} count crew _aircraft;
                private _pilot = driver _aircraft;
                private _group = group effectiveCommander _aircraft;

                _driver setSkill 1;
                _driver allowFleeing 0;

                private _movePos = _pos getPos [1000, _aircraft getDir _pos];
                systemChat str [_aircraft, _passengerCount, _movePos];
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
            };
        }] call ACL_fnc_selectPosition;
    }
] call ACL_fnc_registerModule
