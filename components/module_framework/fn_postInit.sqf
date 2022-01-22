#include "script_component.hpp"

(getAssignedCuratorLogic player) addEventHandler ["CuratorObjectPlaced", {_this call ACL_fnc_onModulePlaced}];
[] call ACL_fnc_loadModuleTree;
