#include "script_component.hpp"

params [
    "_categoryName",
    "_moduleName",
    "_code",
    ["_icon", "\a3\Ui_F_Curator\Data\Logos\arma3_curator_eye_64_ca.paa"]
];

if (isNil "ACL_registeredModules") then {
    ACL_registeredModules = createHashMap;
};

private _moduleDataList = ACL_registeredModules getOrDefault [_categoryName, createHashMap];
_moduleDataList set [_moduleName, [_code, _icon]];
ACL_registeredModules set [_categoryName, _moduleDataList];
