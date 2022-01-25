#include "script_component.hpp"

[
    "Players", "Teleport Player",
    {
        params ["_targetPos"];
        private _players = [allPlayers, [], {name _x}] call BIS_fnc_sortBy;
        ["Teleport Player", [
                [
                    "COMBO",
                    "Name",
                    [0, _players apply {name _x}],
                    true
                ],
                [
                    "TOOLBOX",
                    "Include Group",
                    [0, ["No", "Yes"]]
                ]
            ], {
                params ["_values", "_args"];
                _values params ["_playerIdx", "_includeGroups"];
                _includeGroups = _includeGroups isEqualTo 1;
                _args params ["_targetPos", "_players"];
                private _player = _players select _playerIdx;

                private _toTeleport = if (_includeGroups) then {units _player} else {[_player]};
                [_toTeleport, _targetPos] call ACL_fnc_teleport;
            }, {}, [_targetPos, _players]
        ] call ACL_fnc_createDialog;
    }
] call ACL_fnc_registerModule;

[
    "Players", "Teleport Side",
    {
        params ["_targetPos"];

        ["Teleport Side", [
                [
                    "COMBO",
                    "Side",
                    [0, ["All"] + SIDE_NAMES_TO_SELECT]
                ]
            ], {
                params ["_values", "_targetPos"];
                _values params ["_sideIdx"];
                private _side = ([sideUnknown] + SIDES_TO_SELECT) select _sideIdx;

                private _toTeleport = if (_side isEqualTo sideUnknown) then {
                    allPlayers
                } else {
                    allPlayers select {side _x isEqualTo _side}
                };
                [_toTeleport, _targetPos] call ACL_fnc_teleport;
            }, {}, _targetPos
        ] call ACL_fnc_createDialog;
    }
] call ACL_fnc_registerModule;
