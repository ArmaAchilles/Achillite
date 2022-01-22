#include "script_component.hpp"

params ["_curator", "_logic"];

if (typeOf _logic == "module_f") then {
    curatorMouseOver params ["", ["_entityUnderCursor", objNull]];
    private _display = findDisplay IDD_RSCDISPLAYCURATOR;
    private _ctrl = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_MODULES;
    if (count ACL_moduleTreeCurSel < 2) exitWith {deleteVehicle _logic};
    ACL_moduleTreeCurSel params ["_categoryIdx", "_moduleIdx"];
    private _categoryName = _ctrl tvText [_categoryIdx];
    private _moduleName = _ctrl tvText [_categoryIdx, _moduleIdx];
    // Set the module name for the list of placed assets in the Zeus interface.
    _logic setName _moduleName;
    (ACL_registeredModules get _categoryName get _moduleName) params ["_code"];
    [getPosASL _logic, _entityUnderCursor] call _code;
    deleteVehicle _logic;
};
