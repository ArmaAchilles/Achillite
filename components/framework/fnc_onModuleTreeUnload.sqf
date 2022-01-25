#include "script_component.hpp"

[
    {!isNull (findDisplay IDD_RSCDISPLAYCURATOR)},
    ACL_fnc_onModuleTreeLoad
] call ACL_fnc_waitUntilAndExecute;
