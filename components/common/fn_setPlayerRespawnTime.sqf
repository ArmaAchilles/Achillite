#include "script_component.hpp"

if (isNil "ACL_playerRespawnTime") then {
    ACL_playerRespawnTime = _this;
    publicVariable "ACL_playerRespawnTime";
    [[], {
        player addEventHandler ["Killed", {setPlayerRespawnTime ACL_playerRespawnTime}];
    }] remoteExecCall ["call", 0, "ACL_setPlayerRespawnTime"];
} else {
    ACL_playerRespawnTime = _this;
    publicVariable "ACL_playerRespawnTime";
}
