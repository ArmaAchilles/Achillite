<h1 align="left">Achillite</h1>
<p align="left">
    <img src="https://raw.githubusercontent.com/ArmaAchilles/Achillite/main/extras/assets/img/achilles-wallpaper.jpg" width="512" alt="Achillite">
</p>

<p align="left">
    <a href="https://github.com/ArmaAchilles/Achillite/releases/latest">
        <img src="https://img.shields.io/github/release/ArmaAchilles/Achillite.svg?label=Version&colorB=007EC6&style=flat-square" alt="ACL Version">
    </a>
    <a href="https://github.com/ArmaAchilles/Achillite/issues">
        <img src="https://img.shields.io/github/issues-raw/ArmaAchilles/Achillite.svg?style=flat-square&label=Issues" alt="ACL Issues">
    </a>
    <a href="https://github.com/ArmaAchilles/Achillite/releases">
        <img src="https://img.shields.io/github/downloads/ArmaAchilles/Achillite/total.svg?label=GitHub%20Downloads&colorB=brightgreen&style=flat-square" alt="ACL Downloads">
    </a>
    <a href="https://github.com/ArmaAchilles/Achillite/blob/main/LICENSE">
        <img src="https://img.shields.io/badge/License-GPLv3-red.svg?style=flat-square" alt="ACL License">
    </a>
    <a href="https://discord.gg/kN7Jnhr">
        <img src="https://img.shields.io/discord/364823341506363392.svg?label=Discord&style=flat-square&colorB=7683D5" alt="ZEN Discord">
    </a>
</p>

**Achillite** is a light-weighted client-side editor expansion for [Arma 3 Zeus](https://store.steampowered.com/app/275700/Arma_3_Zeus/) servers that run `zeusCompositionScriptLevel=2`.
It is partially based on [Zeus Enhanced](https://github.com/zen-mod/ZEN) and the now _deprecated_ [Achilles](https://github.com/ArmaAchilles/Achilles) mod.
If you are looking for a full-fledged Zeus editor expansion, check out [Zeus Enhanced](https://github.com/zen-mod/ZEN) instead.

## Installation
1. Subscribe to the composition on the Steam Workshop or get the composition manually from the [GitHub release](https://github.com/ArmaAchilles/Achillite/releases).
2. Play as Zeus.
3. Place the "Achillite Initializer" composition found in the category "Other".
4. Have fun!

## Features
### Modules
- [x] Ambient Animation
- [x] Garrison Buildings
- [x] Paradrop
- [x] Set Captive
- [x] Toggle Attachment
- [x] Toggle Lamps
- [x] Artillery
- [x] Add/Remove Full Arsenal
- [x] Change Group's Side
- [x] Change Side Relations
- [x] Fatigue
- [x] Heal Players
- [x] Set View Distance
- [x] Teleport Players
- [x] Enable Respawn Protection
- [x] Set Respawn Time
- [x] Global Hint
- [x] Update Editable Objects
- [ ] _TBD_
### Keybinds
- [x] Arsenal (<kbd>ALT</kbd>)
- [x] Remote Control (<kbd>CTRL</kbd>)
### API
- [x] Custom dialogs with `ACL_fnc_createDialog`
- [x] Custom modules with `ACL_fnc_registerModule`

## Contributing
You can help out with the ongoing development by looking for potential bugs in our code base, or by contributing new features.
We are always welcoming new pull requests containing bug fixes, refactors and new features.

We have a list of tasks and bugs on our issue tracker on GitHub.
Please comment on issues you want to contribute with, to avoid duplicating effort.

If you want to add a new module, but are not confident with pull requests, just create an [issue](https://github.com/ArmaAchilles/Achillite/issues/new?labels=feature&template=new_module.md) and post the parameters for `ACL_fnc_registerModule`.
For general contributions to Achillite, simply fork this repository and submit your pull requests for review by other collaborators.
Remember to add yourself to the [`AUTHORS.txt`](https://github.com/ArmaAchilles/Achillite/blob/main/AUTHORS.txt).

### Submitting Issues and Feature Requests
Please use our [Issue Tracker](https://github.com/ArmaAchilles/Achillite/issues) to report a bug, propose a feature, or suggest changes to the existing ones.

## License
Achillite is licensed under the The GNU General Public License v3.0 ([GPLv3](https://github.com/ArmaAchilles/Achillite/blob/main/LICENSE)).

## Disclaimer
Depending on the setting of the Zeus server, certain remote executions may lead to a kick from the server. Use this composition at your own risk.
