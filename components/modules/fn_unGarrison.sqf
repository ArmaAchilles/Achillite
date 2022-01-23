#include "script_component.hpp"

[
    "AI", "Un-Garrison Group",
    {
        private _group = group (_this select 1);
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
    }
] call ACL_fnc_registerModule;
