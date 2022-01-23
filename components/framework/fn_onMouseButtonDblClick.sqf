#include "script_component.hpp"

params ["", "_button", "", "", "", "_ctrl"];

if (curatorMouseOver isEqualTo [""]) exitWith {};

// Remote control keybinding
if (_button == 0 && {_ctrl}) exitWith {
    missionnamespace setVariable ["bis_fnc_curatorObjectPlaced_mouseOver", curatorMouseOver];
    private _module = (call ACL_fnc_getGroupLogic) createUnit ["ModuleRemoteControl_F", [0,0,0], [], 0, "CAN_COLLIDE"];
    _module setVariable ["BIS_fnc_initModules_activate", true];
};

(curatorMouseOver select 1) call BIS_fnc_showCuratorAttributes;
