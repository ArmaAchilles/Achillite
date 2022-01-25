#include "script_component.hpp"

ACL_fnc_releaseCaptive = {
    params ["_unit"];

    private _captiveData = _unit getVariable "ACL_captiveData";
    if (alive _unit && !(isNil "_captiveData")) then {
        _unit setUnitLoadout _captiveData;
    };
    _unit setCaptive false;
    _unit call BIS_fnc_ambientAnim__terminate;
    _unit setVariable ["ACL_captiveData", nil];
    _unit remoteExecCall ["RemoveAllActions", 0];
    remoteExecCall ["", _unit];
    _unit removeAllEventHandlers "Killed";
};

[
    "AI", "Set Captive",
    {
        private _unit = [_this, ["Man"], false] call ACL_fnc_checkModuleTarget;
        if (isNil "_unit") exitWith {};

        if !(isNil {_unit getVariable "ACL_captiveData"}) exitWith
        {
            _unit call ACL_fnc_releaseCaptive;
            "CAPTIVE RELEASED" call ACL_fnc_showZeusMessage;
        };

        _unit setVariable ["ACL_captiveData", getUnitLoadout _unit];
        removeAllWeapons _unit;
        removeBackpack _unit;
        _unit addGoggles CAPTIVE_BLINDFOLD;
        removeHeadgear _unit;
        _unit unlinkItem hmd _unit;
        _unit setCaptive true;

        [_unit, CAPTIVE_ANIM, "ASIS"] call BIS_fnc_ambientAnim;

        [
            _unit,
            "Untie Hostage",
            "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa",
            "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa",
            "_this distance _target < 3",
            "_caller distance _target < 3",
            {},
            {},
            {
                params["_unit", "_caller", "_id"];
                _unit remoteExecCall ["ACL_fnc_releaseCaptive", _unit];
            },
            {},
            [],
            7,
            20,
            true,
            false
        ] remoteExecCall ["BIS_fnc_holdActionAdd", 0, _unit];
        _unit addEventHandler ["Killed", ACL_fnc_releaseCaptive];
        "CAPTIVE SET" call ACL_fnc_showZeusMessage;
    }
] call ACL_fnc_registerModule;
