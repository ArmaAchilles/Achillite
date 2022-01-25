#include "script_component.hpp"

    params ["_distance", "_objectDistance", "_shadowDistance"];

_distance remoteExecCall ["setViewDistance", 0, "ACL_setViewDistance"];
[[_objectDistance, _shadowDistance]] remoteExecCall ["setObjectViewDistance", 0, "ACL_setObjectViewDistance"]
