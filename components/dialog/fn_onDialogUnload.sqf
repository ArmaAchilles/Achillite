#include "script_component.hpp"

params ["_display", "_status"];

(_display getVariable "ACL_params") params ["_title", "_onConfirm", "_onCancel", "_args"];

private _values = [];
{
    private _value = _x getVariable "ACL_data";
    if !(isNil "_value") then {_values pushBack _value};
} forEach (allControls (_display displayCtrl IDC_RSCDISPLAYATTRIBUTES_CONTENT));

if (_status isEqualTo 1) then {
    ACL_previousDialogValues set [_title, _values];
    [_values, _args] call _onConfirm;
} else {
    [_values, _args] call _onCancel;
};
