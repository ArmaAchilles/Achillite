#include "script_component.hpp"

if (isNil "ACL_playerRespawnTime") then {
    getNumber (missionConfigFile >> "respawnDelay") // Return value
} else {
    ACL_playerRespawnTime // Return value
}
