#include "script_component.hpp"

[
    "Scenario Flow", "Show Date and Location",
    {
        date apply {
            if (_x < 10) then {format ["0%1", _x]} else {_x}
        } params ["_year", "_month", "_day", "_hour", "_min"];
        private _date = format ["%1-%2-%3 ", _year, _month, _day];
        private _time = format ["%1:%2", _hour, _min];
        private _world = getText (configFile >> "CfgWorlds" >> worldName >> "description");

        {
            [
                [
                    [_date, ""],
                    [_time, "font='PuristaMedium'"],
                    ["", "<br/>"],
                    [toUpper (_x call BIS_fnc_locationDescription), ""],
                    ["", "<br/>"],
                    [_world, ""]
                ],
                safezoneX - 0.01,
                safeZoneY + (1 - 0.125) * safeZoneH,
                true,
                "<t align='right' size='1.0' font='PuristaLight'>%1</t>"
            ] remoteExec ["BIS_fnc_typeText2", _x];
        } forEach allPlayers;
    }
] call ACL_fnc_registerModule;
