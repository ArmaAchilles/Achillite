#include "script_component.hpp"

params ["_side1", "_side2", "_friendly"];

if ((_friendly >= FRIEND_THRESHOLD) && {_side1 getFriend _side2 >= FRIEND_THRESHOLD}) exitWith {};
if ((_friendly < FRIEND_THRESHOLD) && {_side1 getFriend _side2 < FRIEND_THRESHOLD}) exitWith {};

[_side1, [_side2, _friendly]] remoteExecCall ["setFriend", 2];
[_side2, [_side1, _friendly]] remoteExecCall ["setFriend", 2];

private _message = ["SentGenBaseSideEnemy%1", "SentGenBaseSideFriendly%1"] select (_friendly >= FRIEND_THRESHOLD);
[_side1, format [_message, _side2], "side"] remoteExecCall ["BIS_fnc_sayMessage", _side1];
[_side2, format [_message, _side1], "side"] remoteExecCall ["BIS_fnc_sayMessage", _side2];
