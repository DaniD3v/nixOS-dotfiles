{pkgs, lib, ...}: {
  imports = [
    ./swaylock.nix
    ./swww.nix
    ./ags.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.unstable.hyprland;

    settings = {
      env = "WLR_DRM_DEVICES,/dev/dri/card0";

      monitor = [
        "eDP-1,    highrr, 0x0, 1"
        "HDMI-A-1, highrr, 0x0, 1, mirror, eDP-1"
      ];

      exec-once = [
        "${pkgs.systemd}/bin/systemctl --user start swayidle.service"
        "${pkgs.systemd}/bin/systemctl --user start swww.service"

        "${pkgs.dunst}/bin/dunst"
        "ags" # TODO
      ];

      exec = [
        "${../../scripts/wal} ~/wallpaper/pink_landscape.png"
      ];

      windowrule = [
        "suppressevent maximize, class:^(libreoffice.*)$"

        "fullscreen,             Minecraft."
        "tile,                   title:(Burp Suite Community Edition.)"
        "float,                  Calculator"
      ];

      input = {
        kb_layout = "us,de";
        kb_options = "grp:win_space_toggle";

        touchpad = {
          natural_scroll = true;
          disable_while_typing = false;
        };
      };

      general = {
        gaps_out = 10;

        border_size = 2;
        "col.active_border" = "rgba(5f1d82ee) rgba(00c9a7ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
      };

      decoration = {
        rounding = 3;

        blur = {
          size = 8;
          passes = 2;
        };

        shadow_range = 10;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      animation = {
        bezier = [
          "myBezier, 0.05, 0.9, 0.1, 1.05"
        ];

        animation = [
          "windows,     1, 7,  myBezier"
          "windowsOut,  1, 7,  default, popin 80%"
          "border,      1, 10, default"
          "borderangle, 1, 8,  default"
          "fade,        1, 7,  default"
          "workspaces,  1, 6,  default"
        ];
      };

      gestures.workspace_swipe = true;
      misc.force_default_wallpaper = 0;

      "$mainMod" = "SUPER";

      bind = let
        windowMovementKeys = [
          { key = "H"; dir = "l"; }
          { key = "J"; dir = "d"; }
          { key = "K"; dir = "u"; }
          { key = "L"; dir = "r"; }
        ];

        generateWindowMovementLines = { key, dir }: [
          "$mainMod, ${key}, movefocus, ${dir}"
          "$mainMod SHIFT, ${key}, swapwindow, ${dir}"
        ];

        generateWorkspaceMovementLines = workspace:
          let key =
            if workspace == 10 then "0"
            else toString workspace;
          in [
            "$mainMod, ${key}, workspace, ${toString workspace}"
            "$mainMod SHIFT, ${key}, movetoworkspace, ${toString workspace}"
          ];
      in [
        "$mainMod, D, execr, ${pkgs.alacritty}/bin/alacritty"
        "$mainMod, W, execr, ${pkgs.alacritty}/bin/alacritty $EDITOR"
        "$mainMod, E, execr, ${pkgs.gnome.nautilus}/bin/nautilus -w"
        "$mainMod, Q, execr, ${pkgs.firefox}/bin/firefox"
        "$mainMod, A, execr, ${pkgs.gnome.gnome-calculator}/bin/gnome-calculator"
        "$mainMod, N, execr, ${pkgs.gnome-text-editor}/bin/gnome-text-editor"

        # relative path for rofi
        "$mainMod, R, execr, ${pkgs.rofi-wayland}/bin/rofi -show-icons -show drun"
        "$mainMod, O, execr, ${pkgs.swaylock}/bin/swaylock"

        # using relaative path to match version
        "$mainMod, F, execr, ${pkgs.util-linux}/bin/kill -9 $(hyprctl activewindow | ${pkgs.gnugrep}/bin/grep -oP '(?<=pid: ()\\d*)')"
        "$mainMod, C, killactive"
        "$mainMod, V, togglefloating"
        "$mainMod, U, togglesplit"
        "$mainMod SHIFT, M, exit"

        ", XF86AudioMute,        execr, ${pkgs.alsa-utils}/bin/amixer set Master toggle"
        ", XF86AudioMicMute,     execr, ${pkgs.alsa-utils}/bin/amixer set Capture toggle"
        ", XF86AudioRaiseVolume, execr, ${pkgs.alsa-utils}/bin/amixer set Master 5%+"
        ", XF86AudioLowerVolume, execr, ${pkgs.alsa-utils}/bin/amixer set Master 5%-"

        ", XF86MonBrightnessUp,   execr, ${pkgs.brightnessctl}/bin/brightnessctl s 10%+"
        ", XF86MonBrightnessDown, execr, ${pkgs.brightnessctl}/bin/brightnessctl s 10%-"

        ", XF86AudioPlay, execr, ${pkgs.playerctl}/bin/playerctl play"
        ", XF86AudioStop, execr, ${pkgs.playerctl}/bin/playerctl stop"
        ", XF86AudioNext, execr, ${pkgs.playerctl}/bin/playerctl previous"
        ", XF86AudioPrev, execr, ${pkgs.playerctl}/bin/playerctl next"

        ",      PRINT, execr, ${pkgs.unstable.hyprshot}/bin/hyprshot -m output --clipboard-only"
        "CTRL,  PRINT, execr, ${pkgs.unstable.hyprshot}/bin/hyprshot -m window --clipboard-only"
        "SHIFT, PRINT, execr, ${pkgs.unstable.hyprshot}/bin/hyprshot -m region --clipboard-only"

        ", F11, fullscreen"

      ] ++ lib.flatten (
          (map generateWindowMovementLines windowMovementKeys)
          ++ map generateWorkspaceMovementLines (lib.range 1 10)
        );

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };

  # Required packages for the config to work
  home.packages = with pkgs; [
    unstable.swww
    rofi-wayland
    dunst

    brightnessctl
    playerctl

    # screenshots
    wl-clipboard
    slurp
    grim
  ];
}
