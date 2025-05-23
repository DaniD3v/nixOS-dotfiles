{
  pkgs,
  lib,
  config,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.variables = ["--all"];

    settings = {
      source = "~/.config/hypr/hyprland-colors.conf";

      monitor = [
        "eDP-1,    highrr, 0x0, 1"

        "HDMI-A-1, highrr, auto, 1, mirror, eDP-1" # clone monitor
        # "HDMI-A-1, highres, auto, 1" # second monitor
      ];

      workspace = let
        # workspaces 1-9 always select monitor eDP-1 except if
        # HDMI-A-1 created a window on that workspace
        use_edp1 = workspace: "${toString workspace}, monitor:eDP-1";
      in
        [
          "10, monitor:HDMI-A-1, default:true"
        ]
        ++ lib.flatten (map use_edp1 (lib.range 1 9));

      exec-once = [
        "${pkgs.systemd}/bin/systemctl --user start onedrive.service"

        "${pkgs.systemd}/bin/systemctl --user start swww.service"
        "${pkgs.hestia-bar}/bin/hestia-bar"
        "${pkgs.dunst}/bin/dunst"

        "~/.local/bin/wal ~/wallpaper/pink_landscape.png"
      ];

      windowrulev2 = [
        "suppressevent maximize, class:libreoffice-."

        "float,                  title:(Calculator)"
        "fullscreen,             title:(Minecraft.)"
        "tile,                   class:(burp-.)"
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
        border_size = 2;

        gaps_out = 5;
        gaps_in = 3;

        snap = {
          enabled = true;
        };
      };

      decoration = {
        rounding = 5;

        blur = {
          size = 7;
          passes = 4;

          brightness = 0.78;
        };
      };

      animation = {
        bezier = [
          "overshoot, 0.21, 0.82, 0.39, 1.3"
          "overshoot-light, 0.21, 0.82, 0.39, 1.11"
        ];

        animation = [
          "windows,    1, 4, overshoot, popin 80%"
          "workspaces, 1, 6, overshoot-light"
        ];
      };

      gestures.workspace_swipe = true;
      misc.force_default_wallpaper = 0;

      "$mainMod" = "SUPER";

      bind = let
        windowMovementKeys = [
          {
            key = "H";
            dir = "l";
          }
          {
            key = "J";
            dir = "d";
          }
          {
            key = "K";
            dir = "u";
          }
          {
            key = "L";
            dir = "r";
          }
        ];

        generateWindowMovementLines = {
          key,
          dir,
        }: [
          "$mainMod, ${key}, movefocus, ${dir}"
          "$mainMod SHIFT, ${key}, swapwindow, ${dir}"
        ];

        generateWorkspaceMovementLines = workspace: let
          key =
            if workspace == 10
            then "0"
            else toString workspace;
        in [
          "$mainMod, ${key}, workspace, ${toString workspace}"
          "$mainMod SHIFT, ${key}, movetoworkspace, ${toString workspace}"
        ];

        hyprshot-command = "${pkgs.hyprshot}/bin/hyprshot -o ~/screenshots";
      in
        [
          # pass keybind to obs
          "$mainMod, F9, pass,^(com\.obsproject\.Studio)$"

          "$mainMod, bracketleft, movecurrentworkspacetomonitor, eDP-1"
          "$mainMod, bracketright, movecurrentworkspacetomonitor, HDMI-A-1"

          "$mainMod, D, execr, ${pkgs.alacritty}/bin/alacritty"
          "$mainMod, W, execr, ${pkgs.alacritty}/bin/alacritty -e $EDITOR"
          "$mainMod, E, execr, ${pkgs.nautilus}/bin/nautilus -w"
          "$mainMod, Q, execr, ${config.programs.librewolf.package}/bin/librewolf"
          "$mainMod, A, execr, ${pkgs.gnome-calculator}/bin/gnome-calculator"
          "$mainMod, N, execr, ${pkgs.gnome-text-editor}/bin/gnome-text-editor"
          "$mainMod, B, execr, ${pkgs.bitwarden-desktop}/bin/bitwarden"
          "$mainMod, I, execr, ${pkgs.eog}/bin/eog /tmp/screenshot"
          "$mainMod, P, execr, ~/.local/bin/wal ~/wallpaper/$(${pkgs.coreutils}/bin/ls ~/wallpaper | ${pkgs.rofi-wayland}/bin/rofi -dmenu)"

          # relative path for rofi
          "$mainMod, R, execr, ${pkgs.rofi-wayland}/bin/rofi -show-icons -show drun"
          "$mainMod, O, execr, ${pkgs.swaylock-effects}/bin/swaylock"

          "$mainMod, F, execr, ${pkgs.util-linux}/bin/kill -9 $(${config.wayland.windowManager.hyprland.package}/bin/hyprctl activewindow | ${pkgs.gnugrep}/bin/grep -oP '(?<=pid: )\\d+')"
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
          ", XF86AudioNext, execr, ${pkgs.playerctl}/bin/playerctl next"
          ", XF86AudioPrev, execr, ${pkgs.playerctl}/bin/playerctl previous"

          ",      PRINT, execr, ${hyprshot-command} -m output --current; ${pkgs.wl-clipboard}/bin/wl-paste > /tmp/screenshot"
          "CTRL,  PRINT, execr, ${hyprshot-command} -m window; ${pkgs.wl-clipboard}/bin/wl-paste > /tmp/screenshot"
          "SHIFT, PRINT, execr, ${hyprshot-command} -m region; ${pkgs.wl-clipboard}/bin/wl-paste > /tmp/screenshot"

          ", F11, fullscreen"
        ]
        ++ lib.flatten (
          (map generateWindowMovementLines windowMovementKeys)
          ++ map generateWorkspaceMovementLines (lib.range 1 10)
        );

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
