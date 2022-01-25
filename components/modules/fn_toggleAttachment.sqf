#include "script_component.hpp"

[
    "AI", "Toggle Attachment",
    {
        private _unit = [_this, ["Man"]] call ACL_fnc_checkModuleTarget;
        if (isNil "_unit") exitWith {};
        private _group = group _unit;

        private _enabled = missionNamespace getVariable ["ACL_fatigueEnabled", true];
        ["Toggle Attachment", [
                [
                    "TOOLBOX",
                    "Type",
                    [0, ["Flashlight", "IR"]]
                ],
                [
                    "TOOLBOX",
                    "Status",
                    [1, ["Disabled", "Enabled"]]
                ],
                [
                    "TOOLBOX",
                    "Add Gear",
                    [1, ["No", "Yes"]]
                ],
                [
                    "TOOLBOX",
                    "Remove NVG",
                    [1, ["No", "Yes"]]
                ]
            ], {
                params ["_values", "_group"];
                _values params ["_type", "_enable", "_add", "_removeNVG"];
                _enable = _enable isEqualTo 1;
                _add = _add isEqualTo 1;
                _removeNVG = _removeNVG isEqualTo 1;

                ([
                    [ACL_fnc_enableGunLights, "acc_flashlight"],
                    [ACL_fnc_enableIRLasers, "acc_pointer_IR"]
                ] select _type) params ["_fnc_enableAttachment", "_attachment"];

                if (_add) then {
                    {
                        _x addWeaponItem [primaryWeapon _x, _attachment];
                    }forEach units _group
                };
                [_fnc_enableAttachment, [_group, _enable]] call ACL_fnc_execNextFrame;

                if (_removeNVG) then {
                    {_x unlinkItem hmd _x} forEach units _group;
                };
            }, {}, _group
        ] call ACL_fnc_createDialog;
    }
] call ACL_fnc_registerModule;
