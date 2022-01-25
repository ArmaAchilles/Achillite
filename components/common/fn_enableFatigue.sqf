#include "script_component.hpp"

if (isNil "ACL_fatigueEnabled") then {
    ACL_fatigueEnabled = _this;
    publicVariable "ACL_fatigueEnabled";
    [[], {
        player enableFatigue ACL_fatigueEnabled;
        player addEventHandler ["respawn", {_this select 0 enableFatigue ACL_fatigueEnabled}];
    }] remoteExecCall ["call", 0, "ACL_enableFatigue"];
} else {
    ACL_fatigueEnabled = _this;
    publicVariable "ACL_fatigueEnabled";
}
