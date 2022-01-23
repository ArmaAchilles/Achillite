#include "script_component.hpp"

params ["_display", "_ctrlContent", "_ctrlParams", "_initialValue"];
_ctrlParams params ["_ctrlType", "_label", "_args", ["_forceDefault", false]];

private _ctrlGroup = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1, _ctrlContent];

private _nGridH = 1;

switch (_ctrlType) do {
    case "EDIT": {
        _args params [
            ["_defaultValue", "", [""]],
            ["_nLines", 1, [0]]
        ];
        _nGridH = _nLines;
        private _ctrlClass = if (_nLines > 1) then {"RscEditMulti"} else {"RscEdit"};
        private _ctrlEdit = _display ctrlCreate [_ctrlClass, -1, _ctrlGroup];
        _ctrlEdit ctrlSetPosition POS(10.1, 0, 15.9, _nGridH);
        _ctrlEdit ctrlSetBackgroundColor FIELD_BACKGROUND_COLOR;
        _ctrlEdit ctrlCommit 0;

        if (_forceDefault || {isNil "_initialValue"}) then {
            _initialValue = _defaultValue;
        };
        _ctrlEdit ctrlSetText _initialValue;
        _ctrlEdit setVariable ["ACL_data", _initialValue];
        _ctrlEdit ctrlSetEventHandler ["KeyUp", " \
            params ['_ctrl']; \
            _ctrl setVariable ['ACL_data', ctrlText _ctrl]; \
            true \
        "];
    };
    case "TOOLBOX": {
        _args params [
            ["_defaultValue", 0, [0]],
            ["_optionNames", [], [[]]]
        ];

        private _ctrlToolbox = _display ctrlCreate ["RscToolbox", -1, _ctrlGroup];
        _ctrlToolbox ctrlSetPosition POS(10.1, 0, 15.9, _nGridH);
        _ctrlToolbox ctrlSetBackgroundColor FIELD_BACKGROUND_COLOR;
        _ctrlToolbox ctrlCommit 0;

        {_ctrlToolbox lbSetText [_forEachIndex, _x]} forEach _optionNames;
        if (_forceDefault || {isNil "_initialValue"}) then {
            _initialValue = _defaultValue;
        };
        _ctrlToolbox lbSetCurSel _initialValue;
        _ctrlToolbox setVariable ["ACL_data", _initialValue];
        _ctrlToolbox ctrlSetEventHandler ["ToolBoxSelChanged", " \
            params ['_ctrl', '_sel']; \
            _ctrl setVariable ['ACL_data', _sel]; \
            true \
        "];
    };
    case "COMBO": {
        _args params [
            ["_defaultValue", 0, [0]],
            ["_optionNames", [], [[]]]
        ];

        private _ctrlCombo = _display ctrlCreate ["RscCombo", -1, _ctrlGroup];
        _ctrlCombo ctrlSetPosition POS(10.1, 0, 15.9, _nGridH);
        _ctrlCombo ctrlSetBackgroundColor FIELD_BACKGROUND_COLOR;
        _ctrlCombo ctrlCommit 0;

        {_ctrlCombo lbAdd _x} forEach _optionNames;
        if (_forceDefault || {isNil "_initialValue"}) then {
            _initialValue = _defaultValue;
        };
        _ctrlCombo lbSetCurSel _initialValue;
        _ctrlCombo setVariable ["ACL_data", _initialValue];
        _ctrlCombo ctrlSetEventHandler ["LBSelChanged", " \
            params ['_ctrl', '_sel']; \
            _ctrl setVariable ['ACL_data', _sel]; \
            true \
        "];
    };
};

_ctrlGroup ctrlSetPosition POS(0, 0, 26, _nGridH);
_ctrlGroup ctrlCommit 0;

private _ctrlLabel = _display ctrlCreate ["RscText", -1, _ctrlGroup];
_ctrlLabel ctrlSetPosition POS(0, 0, 10, _nGridH);
_ctrlLabel ctrlSetBackgroundColor LABEL_BACKGROUND_COLOR;
_ctrlLabel ctrlSetText _label;
_ctrlLabel ctrlCommit 0;

_ctrlGroup // return value
