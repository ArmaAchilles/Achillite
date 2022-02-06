#include "script_component.hpp"

params ["_aircraft", "_cargo"];

switch (true) do {
    case (_aircraft canVehicleCargo _cargo select 0): {
        _aircraft setVehicleCargo _cargo;
    };
    case (_aircraft canSlingload _cargo): {
        _aircraft setSlingload _cargo;
    };
};
