#include "script_component.hpp"

params [
    ["_title", "", [""]],
    ["_content", [], [[]]],
    ["_onConfirm", {}, [{}]],
    ["_onCancel", {}, [{}]],
    ["_args", []]
];

if (isNil "ACL_previousDialogValues") then {
    ACL_previousDialogValues = createHashMap;
};
private _savedValues = ACL_previousDialogValues getOrDefault [_title, []];

createDialog "RscDisplayAttributes";
private _display = findDisplay -1;
_display setVariable ["ACL_params", [_title, _onConfirm, _onCancel, _args]];
_display displayAddEventHandler ["UnLoad", ACL_fnc_onDialogUnload];

private _ctrlBackground = _display displayCtrl IDC_RSCDISPLAYATTRIBUTES_BACKGROUND;
private _ctrlTitle = _display displayCtrl IDC_RSCDISPLAYATTRIBUTES_TITLE;
private _ctrlContent = _display displayCtrl IDC_RSCDISPLAYATTRIBUTES_CONTENT;
private _ctrlButtonOK = _display displayCtrl IDC_OK;
private _ctrlButtonCancel = _display displayCtrl IDC_CANCEL;
private _ctrlButtonCustom = _display displayCtrl IDC_RSCDISPLAYATTRIBUTES_BUTTONCUSTOM;

(ctrlPosition _ctrlBackground) params ["", "_ctrlBackgroundPosY"];
(ctrlPosition _ctrlTitle) params ["", "_ctrlTitlePosY", "", "_ctrlTitlePosH"];
(ctrlPosition _ctrlContent) params ["", "_ctrlContentPosY"];

private _ctrlTitleOffsetY = _ctrlBackgroundPosY - _ctrlTitlePosY - _ctrlTitlePosH;
private _ctrlContentOffsetY = _ctrlContentPosY - _ctrlBackgroundPosY + 0.02;

private _posY = _ctrlContentOffsetY;
{
    private _ctrl = [
        _display, _ctrlContent, _x,
        _savedValues param [_forEachIndex]
    ] call ACL_fnc_createCtrl;
    _ctrl ctrlSetPositionX 0;
    _ctrl ctrlSetPositionY _posY;
    _ctrl ctrlCommit 0;
    _posY = _posY + ((ctrlPosition _ctrl) select 3) + 0.005;
    ctrlSetFocus _ctrl;
} forEach _content;
_posH = ((_posY + _ctrlContentOffsetY) min 0.9) * 0.5;

_ctrlTitle ctrlSetText _title;
_ctrlTitle ctrlSetPositionY ((0.5 - _posH) - _ctrlTitlePosH - _ctrlTitleOffsetY);
_ctrlTitle ctrlCommit 0;

_ctrlContent ctrlSetPositionY (0.5 - _posH);
_ctrlContent ctrlSetPositionH (_posH * 2);
_ctrlContent ctrlCommit 0;

_ctrlBackground ctrlSetPositionY (0.5 - _posH);
_ctrlBackground ctrlSetPositionH (_posH * 2);
_ctrlBackground ctrlCommit 0;

_ctrlButtonOK ctrlSetPositionY (0.5 + _posH + _ctrlTitleOffsetY);
_ctrlButtonOK ctrlCommit 0;
ctrlSetFocus _ctrlButtonOK;

_ctrlButtonCancel ctrlSetPositionY (0.5 + _posH + _ctrlTitleOffsetY);
_ctrlButtonCancel ctrlCommit 0;

_ctrlButtonCustom ctrlShow false;
