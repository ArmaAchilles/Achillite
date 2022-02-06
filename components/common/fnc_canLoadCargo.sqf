#include "script_component.hpp"

params ["_vehicle", "_cargo"];

(_vehicle canVehicleCargo _cargo select 0) || {_vehicle canSlingload _cargo}
