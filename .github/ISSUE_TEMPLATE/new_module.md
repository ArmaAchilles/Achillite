---
name: New module
about: Suggest a new module by providing the parameters for `ACL_fnc_registerModule`
title: ''
labels: feature
assignees: ''
---

**Description**
Describe what your module does

**Code**
```sqf
[
    "MyModules", "Hello World",
    {
        sytemChat "Hello World"
    }
] call ACL_fnc_registerModule
```
