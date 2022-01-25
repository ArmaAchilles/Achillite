#include "script_component.hpp"

params ["", "_button", "", "", "", "_ctrl", "_alt"];

if (curatorMouseOver isEqualTo [""]) exitWith {};

// Remote control keybinding
if (_button == 0) then {
    private _moduleClass = switch (true) do {
        case (_ctrl): {"ModuleRemoteControl_F"};
        case (_alt): {"ModuleArsenal_F"};
        default {""};
    };

    if (_moduleClass isNotEqualTo "") exitWith {
        missionnamespace setVariable ["bis_fnc_curatorObjectPlaced_mouseOver", curatorMouseOver];
        private _module = (call ACL_fnc_getGroupLogic) createUnit [_moduleClass, [0,0,0], [], 0, "CAN_COLLIDE"];
        _module setvariable ["bis_fnc_curatorAttachObject_object", curatorMouseOver select 1];
        _module setVariable ["BIS_fnc_initModules_activate", true];
    };

    if ((curatorMouseOver select 0) isEqualTo typeName []) then {
        (curatorMouseOver select [1, 2]) call BIS_fnc_showCuratorAttributes;
    } else {
        (curatorMouseOver select 1) call BIS_fnc_showCuratorAttributes;
    };
};
