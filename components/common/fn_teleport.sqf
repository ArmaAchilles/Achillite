#include "script_component.hpp"

params ["_units", "_pos"];

// Teleport vehicle if unit is in vehicle
_units = _units apply {vehicle _x};
_units = _units arrayIntersect _units;

// Ensure proper spacing among units
private _gridSize = TELEPORT_SPACING + selectMax (_units apply {(sizeOf typeOf _x) / 2});
private _nGrid = ceil sqrt count _units;
private _offset = _gridSize * floor (_nGrid / 2);
private _startPos = _pos vectorDiff [_offset, _offset, 0];
private _posList = [];
for "_i" from 0 to (_nGrid - 1) do {
    for "_j" from 0 to (_nGrid - 1) do {
        _posList pushBack (_startPos vectorAdd [_i * _gridSize, _j * _gridSize, 0]);
    };
};

{
    private _pos = _posList select _forEachIndex;

    // Based on mharis001's implementation in ZEN
    // Special handling for aircraft that are flying
    // Without "FLY" they will be teleported to the ground and explode
    // Manually set their velocity to prevent them from falling out of the sky
    if (_x isKindOf "Air" && {getPosATL _x select 2 > 2}) then {
        _x setVehiclePosition [_pos, [], 0, "FLY"];
        _x setVelocity velocity _x;
    } else {
        _x setVehiclePosition [_pos, [], 0, "NONE"];
        _x setVelocity [0, 0, 0];
    };
} forEach _units;
