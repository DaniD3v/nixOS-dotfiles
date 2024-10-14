{pkgs, ...}: {
  wayland.windowManager.hyprland.settings.bind = [
    ", XF86KbdBrightnessUp,   execr, ${pkgs.brightnessctl}/bin/brightnessctl --device asus::kbd_backlight s +1"
    ", XF86KbdBrightnessDown, execr, ${pkgs.brightnessctl}/bin/brightnessctl --device asus::kbd_backlight s 1-"

    ", XF86Launch3, execr, ${pkgs.asusctl}/bin/asusctl led-mode -n"
    ", XF86Launch4, execr, ${pkgs.asusctl}/bin/asusctl profile -n"

    ", XF86TouchpadToggle, execr, ~/.local/bin/toggle_touchpad"
  ];
}
