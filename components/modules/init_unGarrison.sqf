#include "script_component.hpp"

[
    "AI", "Un-Garrison Group",
    {
        private _unit = [_this, ["Man"], false] call ACL_fnc_checkModuleTarget;
        if (isNil "_unit") exitWith {};

        private _group = group _unit;
        private _leader = leader _group;
        {
            _x enableAI "PATH";
            _x setUnitPos "AUTO";

            if (_leader isEqualTo _x) then {
                 _x doMove (nearestBuilding _x buildingExit 0);
            } else {
                _x doFollow _leader;
            };
        } forEach units _group;

        "GARRISON TERMINATED" call ACL_fnc_showZeusMessage;
    }
] call ACL_fnc_registerModule;
