#include "script_component.hpp"

[{
    params [
        ["_objects", [], [objNull, []]],
        ["_function", {}, [{}]],
        ["_args", []],
        ["_icon", "\a3\ui_f\data\igui\cfg\cursors\select_target_ca.paa", [""]],
        ["_color", [1, 0, 0, 1], [[]], 4]
    ];

    private _display = findDisplay IDD_RSCDISPLAYCURATOR;
    private _ctrlMap = _display displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP;

    private _mouseHandle = _display displayAddEventHandler ["MouseButtonUp", {
        params ["_display", "_button", "_xPos", "_yPos"];
        ACL_selectPositionData params ["_objects", "_function", "_args", "", "", "_mouseHandle", "_draw3dHandle", "_drawHandle"];
        private _ctrlMap = _display displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP;
        _display displayRemoveEventHandler ["MouseButtonUp", _mouseHandle];
        removeMissionEventHandler ["Draw3D", _draw3dHandle];
        _ctrlMap ctrlRemoveEventHandler ["Draw", _drawHandle];

        if (_button isEqualTo 0) then {
            private _pos = if (visibleMap) then {
                _ctrlMap posScreenToWorld [_xPos, _yPos];
            } else {
                screenToWorld [_xPos, _yPos];
            };
            [true, _objects, _pos, _args] call _function;
        } else {
            [false, _objects, [0, 0, 0], _args] call _function;
        };
    }];

    private _draw3dHandle = addMissionEventHandler ["Draw3D", {
        if (visibleMap) exitWith {};
        ACL_selectPositionData params ["_objects", "", "", "_icon", "_color"];
        private _pos = screenToWorld getMousePosition;
        drawIcon3D [_icon, _color, _pos, 1.5, 1.5, 45];
        {
            drawLine3d [getPos _x, _pos, _color];
        } forEach _objects;
    }];

    private _drawHandle = _ctrlMap ctrlAddEventHandler ["Draw", {
        params ["_mapCtrl"];
        ACL_selectPositionData params ["_objects", "", "", "_icon", "_color"];
        private _pos = _mapCtrl ctrlMapScreenToWorld getMousePosition;
        _mapCtrl drawIcon [_icon, _color, _pos, 40, 40, 45];
        {
            _mapCtrl drawLine [getPos _x, _pos, _color];
        } forEach _objects;
    }];

    ACL_selectPositionData = [_objects, _function, _args, _icon, _color, _mouseHandle, _draw3dHandle, _drawHandle];
}, _this] call ACL_fnc_execNextFrame; // Execute in next frame to avoid conflict with preceding dialog
