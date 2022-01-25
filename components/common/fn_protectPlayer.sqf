#include "script_component.hpp"

params ["_player", "_protected"];

if (isNil "ACL_fnc_protectPlayerLocal") then {
    ACL_fnc_protectPlayerLocal = {
        if (_this) then {
            player addEventHandler ["FiredMan", {deleteVehicle param [6]}];
            player allowDamage false;
            hint "Respawn protection enabled!";
        } else {
            player removeAllEventHandlers "FiredMan";
            player allowDamage true;
            hint "Respawn protection disabled!";
        };
    };

    publicVariable "ACL_fnc_protectPlayerLocal";
};

_protected remoteExecCall ["ACL_fnc_protectPlayerLocal", _player];
