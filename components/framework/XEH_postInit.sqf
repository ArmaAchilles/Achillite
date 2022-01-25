#include "script_component.hpp"

private _curator = getAssignedCuratorLogic player;
// Double click get replaced by ACL_fnc_onMouseButtonDblClick
_curator removeAllEventHandlers "CuratorObjectDoubleClicked";
_curator removeAllEventHandlers "CuratorGroupDoubleClicked";
_curator removeAllEventHandlers "CuratorWaypointDoubleClicked";
_curator removeAllEventHandlers "CuratorMarkerDoubleClicked";
_curator addEventHandler ["CuratorObjectPlaced", ACL_fnc_onModulePlaced];

[] call ACL_fnc_onModuleTreeLoad;
