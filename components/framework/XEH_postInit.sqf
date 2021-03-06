#include "script_component.hpp"

private _curator = getAssignedCuratorLogic player;
// Double click get replaced by ACL_fnc_onMouseButtonDblClick
_curator removeAllEventHandlers "CuratorObjectDoubleClicked";
_curator removeAllEventHandlers "CuratorGroupDoubleClicked";
_curator removeAllEventHandlers "CuratorWaypointDoubleClicked";
_curator removeAllEventHandlers "CuratorMarkerDoubleClicked";
_curator addEventHandler ["CuratorObjectPlaced", ACL_fnc_onModulePlaced];
_curator addEventHandler ["CuratorObjectEdited", ACL_fnc_onObjectEdited];
_curator addEventHandler ["CuratorGroupPlaced", ACL_fnc_onGroupPlaced];

[] call ACL_fnc_onModuleTreeLoad;
