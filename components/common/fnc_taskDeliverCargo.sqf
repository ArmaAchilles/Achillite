#include "script_component.hpp"

params ["_aircraft", "_cargo", "_pos"];

private _pilot = driver _aircraft;
_pilot setSkill 1;
_pilot allowFleeing 0;

switch (true) do {
    case !(isNull isVehicleCargo _cargo): {
        [_aircraft, _pos] call ACL_fnc_taskParadrop;
        private _wp = (group _aircraft) addWaypoint [_pos, 0];
        _wp setWaypointType "SCRIPTED";
        _wp setWaypointStatements ["unitReady vehicle this", ""];
    };
    case (ropeAttachedTo _cargo isEqualTo _aircraft): {
        private _wp = (group _aircraft) addWaypoint [_pos, 0];
        _wp setWaypointType "UNHOOK";
    };
};
