#include "script_component.hpp"

[
    "AI", "Garrison Group",
    {
        ["Garrison Group", [
                [
                    "EDIT",
                    "Radius [m]",
                    "100"
                ],
                [
                    "COMBO",
                    "Place",
                    [0, ["Anywhere", "Inside Only", "Outside Only"]]
                ],
                [
                    "TOOLBOX",
                    "Fill Mode",
                    [0, ["Randomly", "Building by Building"]]
                ]
            ], {
                params ["_values", "_args"];
                _values params ["_radius", "_placementMode", "_fillMode"];
                _radius = parseNumber _radius;
                private _shufflePos = _fillMode isEqualTo 0;
                private _fnc_posFilter = switch (_placementMode) do {
                    case 0: {{true}};
                    case 1: {{_this call ACL_fnc_isInsideBuilding}};
                    case 2: {{!(_this call ACL_fnc_isInsideBuilding)}};
                };
                _args params ["_center", "_unit"];
                private _buildings = nearestObjects [_center, ["building"], _radius, true];

                // Compile list of positions
                private _posListBuildings = [];
                {
                    private _building = _x;
                    private _posList = _building call ACL_fnc_buildingPositions;
                    _posList = _posList select {
                        [_x, _building] call _fnc_posFilter
                    };
                    _posListBuildings append _posList;
                } forEach _buildings;
                if (_shufflePos) then {
                    _posListBuildings = _posListBuildings call BIS_fnc_arrayShuffle
                };

                {
                    private _unit = _x;
                    private _pos = _posListBuildings param [_forEachIndex];
                    if (isNil "_pos") exitWith {};
                    _unit setPosASL _pos;
                    private _eyePosASL = _pos vectorAdd [0, 0, EYE_HEIGHT];

                    doStop _unit;
                    _unit disableAI "PATH";
                    _unit setUnitPos "UP";

                    // Sample angles
                    private _startAngle = random 360;
                    private _angles = [];
                    for "_angle" from _startAngle to (_startAngle + 360) step 10 do {_angles pushBack _angle};
                    _angles = _angles call BIS_fnc_arrayShuffle;

                    // Rotate unit for a good line of sight
                    private _bestDistance = 0;
                    private _bestAngle = _startAngle;
                    {
                        private _tgtPosASL = _eyePosASL vectorAdd [GARRISON_PROBE_LOS * sin _x, GARRISON_PROBE_LOS * cos _x, 0];
                        private _intersections = lineIntersectsSurfaces [_eyePosASL, _tgtPosASL, _unit];
                        private _distance = if (_intersections isEqualTo []) then {
                            GARRISON_PROBE_LOS
                        } else {
                            (_intersections select 0 select 0) distance2D _eyePosASL
                        };

                        if (_distance > _bestDistance) then {
                            _bestAngle = _x;
                            _bestDistance = _distance;
                        };
                    } forEach _angles;
                    _unit doWatch (_eyePosASL vectorAdd [GARRISON_PROBE_LOS * sin _bestAngle, GARRISON_PROBE_LOS * cos _bestAngle, 0]);
                    _unit setDir _bestAngle;
                } forEach (units group _unit);
            }, {}, _this
        ] call ACL_fnc_createDialog;
    }
] call ACL_fnc_registerModule;
