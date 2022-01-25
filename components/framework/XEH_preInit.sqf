#include "script_component.hpp"

ACL_fnc_showZeusErrorMessage = {
    [objNull, _this] call bis_fnc_showCuratorFeedbackMessage;
    playSound "FD_Start_F";
};

ACL_fnc_showZeusMessage = {
    [objNull, _this] call bis_fnc_showCuratorFeedbackMessage;
};
