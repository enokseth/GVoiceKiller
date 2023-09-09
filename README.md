# GVoiceKiller

![GitHub stars](https://img.shields.io/github/stars/enokseth/GVoiceKiller.svg?style=social)
![GitHub forks](https://img.shields.io/github/forks/enokseth/GVoiceKiller.svg?style=social)
![GitHub watchers](https://img.shields.io/github/watchers/enokseth/GVoiceKiller.svg?style=social)
![GitHub followers](https://img.shields.io/github/followers/enokseth.svg?style=social)

A script to remove the `HotWord`  `Ok Google`  and `Quick Search Box`  application `from`  your `Android device` 

## Customization

The script consists of two main parts: `customize.sh` and `service.sh`.

### customize.sh

This script is `executed during the module installation` 

It performs the following operations:

1.`Checks the device architecture.`
2. Unmounts `Quick Search Box`,  mounts `if they exist`.
3. `Force stops` the Quick Search Box application.
4. `Checks` if the `Quick Search Box` application `is already installed or not`.
5. `If` the `Quick Search Box` application `does not have version 1.0.0`, it `uninstalls` it.
6. Cleans up temporary files.

### service.sh

This script is `executed on device boot` for `ensure app is been deleted`.

( future feature `post-fs.sh [add persistance ]` ). 

It performs the following operations:

1. `Waits for the device boot` to complete.
2. Waits for the `/sdcard/Android` folder to be available.
3. `Checks` if the `Quick Search Box` application `is installed`.
4. `If` the `Quick Search Box` application `is installed`, `it checks if it is running and mounted`.
5. If the Quick Search Box application is running and mounted, it `disables and unmounts it`.

## Usage

1. `Install the module on your Android device using Magisk Manager`.
2. Reboot your device to activate the boot service.
3. The HotWord `Ok Google` and `Quick Search Box` applications `will be removed` and reboot.

## Contributors

- [Enok._.Seth](https://github.com/enokseth) - Main Author

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
