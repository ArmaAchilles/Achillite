#include "script_component.hpp"

private _display = findDisplay IDD_RSCDISPLAYCURATOR;
private _ctrl = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_MODULES;

// Display event handlers
_ctrl ctrlAddEventHandler ["TreeSelChanged", {
    params["","_path"];
    if (_path isNotEqualTo []) then {
        ACL_moduleTreeCurSel = _path
    }
}];
_display displayAddEventHandler ["Unload", ACL_fnc_onModuleTreeUnload];
{
    (_display displayCtrl _x) ctrlAddEventHandler ["MouseButtonDblClick", ACL_fnc_onMouseButtonDblClick];
} forEach [
    IDC_RSCDISPLAYCURATOR_MOUSEAREA,
    IDC_RSCDISPLAYCURATOR_MAINMAP
];

[] call ACL_fnc_loadModules;
