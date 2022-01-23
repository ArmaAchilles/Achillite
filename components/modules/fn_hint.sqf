#include "script_component.hpp"

[
    "Zeus", "Global Hint",
    {
        ["Global Hint", [
                ["EDIT", "Message", ["", 5]]
            ], {
                (_this select 0 select 0) remoteExecCall ["hint", 0];
            }
        ] call ACL_fnc_createDialog;
    }
] call ACL_fnc_registerModule;
