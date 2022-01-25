#include "script_component.hpp"

params [
    ["_moduleParams", []],
    ["_allowedTypes", []],
    ["_allowPlayers", true],
    ["_allowNonPlayers", true]
];
_moduleParams params ["", "_entity"];

if (isNull _entity) exitWith {
    "HAS TO BE PLACED ON AN ENTITY" call ACL_fnc_showZeusErrorMessage;
    nil // Return value
};

if !(alive _entity) exitWith {
    "HAS TO BE PLACED ON AN ALIVE ENTITY" call ACL_fnc_showZeusErrorMessage;
    nil // Return value
};

if (_allowedTypes isNotEqualTo [] && {_allowedTypes findIf {_entity isKindOf _x} < 0}) exitWIth {
    ("HAS TO BE PLACED ON " + (_allowedTypes joinString " OR ")) call ACL_fnc_showZeusErrorMessage;
    nil // Return value
};

if (isPlayer _entity && !_allowPlayers) exitWith {
    "CANNOT BE PLACED ON PLAYERS" call ACL_fnc_showZeusErrorMessage;
    nil // Return value
};

if (!isPlayer _entity && !_allowNonPlayers) exitWith {
    "CANNOT BE PLACED ON NON-PLAYERS" call ACL_fnc_showZeusErrorMessage;
    nil // Return value
};

_entity // Return value
