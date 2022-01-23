#include "script_component.hpp"

[
    "Zeus", "Update Editable Objects",
    {
        params ["_posASL"];

        ["Update Editable Objects", [
                [
                    "TOOLBOX",
                    "Update Mode",
                    [1, ["Remove Objects", "Add Objects"]]
                ],
                [
                    "TOOLBOX",
                    "Selection Mode",
                    [0, ["Radius [m]", "All Mission Objects"]]
                ],
                [
                    "EDIT",
                    "Radius",
                    "100"
                ]
            ], {
                params ["_values", "_posASL"];
                _values params ["_updateMode", "_selectionMode", "_radius"];

                private _objects = switch (_selectionMode) do {
                    case 0: {
                        _radius = parseNumber _radius;
                         nearestObjects [ASLToAGL _posASL, ["All"], _radius, true]
                    };
                    case 1: {
                        allMissionObjects "All"
                    };
                };

                if (_updateMode isEqualTo 1) then {
                    _objects call ACL_fnc_addObjects;
                } else {
                    _objects call ACL_fnc_removeObjects;
                };
            }, {}, _posASL
        ] call ACL_fnc_createDialog;
    }
] call ACL_fnc_registerModule
