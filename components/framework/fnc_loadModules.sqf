#include "script_component.hpp"

private _display = findDisplay IDD_RSCDISPLAYCURATOR;
private _ctrl = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_MODULES;

{
    private _categoryName = _x;
    private _categoryIdx = -1;
    for "_i" from 0 to ((_ctrl tvCount []) - 1) do {
        if (_categoryName isEqualTo (_ctrl tvText [_i])) exitWith {
            _categoryIdx = _i
        };
    };
    if (_categoryIdx < 0) then {
        _categoryIdx =  _ctrl tvAdd [[], _categoryName];
    };
    _ctrl tvSetPicture [[_categoryIdx], "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeRecent_ca.paa"];

    {
        private _moduleName = _x;
        private _moduleIdx = -1;
        for "_i" from 0 to ((_ctrl tvCount [_categoryIdx]) - 1) do {
            if (_moduleName isEqualTo (_ctrl tvText [_categoryIdx, _i])) exitWith {
                _moduleIdx = _i
            };
        };
        if (_moduleIdx < 0) then {
            _moduleIdx =  _ctrl tvAdd [[_categoryIdx], _moduleName];
        };
        _y params ["_code", "_icon"];
        private _moduleClass = if (_code isEqualType "") then {_code} else {"module_f"};
        _ctrl tvSetData [[_categoryIdx, _moduleIdx], _moduleClass];
        _ctrl tvSetPicture [[_categoryIdx, _moduleIdx], _icon];
    } forEach _y;
    _ctrl tvSort [[_categoryIdx], false];
} forEach ACL_registeredModules;
_ctrl tvSort [[], false];
