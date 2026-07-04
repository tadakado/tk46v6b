# tk46v6b

ZMK firmware configuration for the **tk46v6b** — a 46-key column-staggered split
keyboard built from two [Seeed XIAO nRF52840](https://wiki.seeedstudio.com/XIAO_BLE/)
boards, with a Japanese-oriented keymap.

It is the successor to [tk46v6a](https://github.com/tadakado/tk46v6a): the CH559
USB-mouse bridge is replaced by a **BLE mouse host**, so an external Bluetooth
mouse connects straight to the keyboard.

## Features

- **External BLE mouse host** ([zmk-ble-mouse-host](https://github.com/tadakado/zmk-ble-mouse-host)) —
  pair a Bluetooth mouse to the keyboard; its pointer rides the keyboard's active
  output, so switching the keyboard between USB / BLE profiles moves the mouse
  with it. Includes per-endpoint scroll-wheel inversion.
- **IR transmit + receive** ([zmk-ir](https://github.com/tadakado/zmk-ir)) —
  NEC IR codes are sent on output switching (to steer an IR device's input), and
  an IR receiver decodes remotes to the log.
- **Connection indicator** ([zmk-rgb-indicator](https://github.com/tadakado/zmk-rgb-indicator)) —
  overlays the active USB/BLE-profile color on one WS2812 underglow pixel.
- **1200-baud bootloader entry** ([zmk-bootloader-1200](https://github.com/tadakado/zmk-bootloader-1200)) —
  enter the UF2 bootloader via an Arduino-style 1200-baud USB touch, no RESET
  double-tap needed.
- **BLE debug helpers** ([zmk-ble-debug](https://github.com/tadakado/zmk-ble-debug)) —
  a `&ble_dump` bond/profile dump and an opt-in host-link RSSI logger.

## Layout

Four layers: default, lower, raise, and an adjust layer (lower + raise via a
conditional/tri-layer). The adjust layer carries output selection
(`&sel_usb` / `&sel_ble0`–`4`, each also sending the matching IR code), BLE
`BT_CLR` / `BT_CLR_ALL`, a combined bond dump (`&bond_dump_act`), mouse
`&mouse_pair` / `&mouse_unpair`, media keys, and RGB underglow controls.

## Shields

| Shield | Role |
| --- | --- |
| `tk46v6_left` | Left / **central** half — BLE mouse host, IR TX/RX, ZMK Studio |
| `tk46v6_right` | Right / **peripheral** half |
| `devkit` | Single XIAO test board (non-split), same feature set |
| `settings_reset` | Built-in ZMK utility to clear BLE bonds |

## Building & flashing

Every push is built by GitHub Actions (**Actions** tab → latest run →
**Artifacts**). Download the `.uf2` for the half you want, then flash it:

1. Put the XIAO in bootloader mode — double-tap RESET, or (if already running
   this firmware) do a 1200-baud touch on its USB serial port; a `XIAO-BOOT`
   drive appears.
2. Copy the `.uf2` onto that drive. The board reboots automatically.

Flash `settings_reset` first if you need to clear stale BLE bonds, then flash
the real firmware.

## Modules

Pulled automatically by `config/west.yml` (no `ZMK_EXTRA_MODULES` needed):
[zmk-ble-mouse-host](https://github.com/tadakado/zmk-ble-mouse-host),
[zmk-ir](https://github.com/tadakado/zmk-ir),
[zmk-rgb-indicator](https://github.com/tadakado/zmk-rgb-indicator),
[zmk-ble-debug](https://github.com/tadakado/zmk-ble-debug),
[zmk-bootloader-1200](https://github.com/tadakado/zmk-bootloader-1200).

Built on [ZMK Firmware](https://zmk.dev).
