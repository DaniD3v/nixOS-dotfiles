{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./swaylock.nix
    ./swww.nix
    ./ags.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      monitor = [
        "eDP-1,    highrr, 0x0, 1"

        # "HDMI-A-1, highrr, 0x0, 1, mirror, eDP-1" # clone monitor
        "HDMI-A-1, highrr, auto-up, 1" # second monitor
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
        "${pkgs.systemd}/bin/systemctl --user start swayidle.service"
        "${pkgs.systemd}/bin/systemctl --user start swww.service"

        "${pkgs.dunst}/bin/dunst"
        "${pkgs.ags}/bin/ags"
      ];

      exec = [
        "~/.local/bin/wal ~/wallpaper/pink_landscape.png"
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

        "col.active_border" = "rgba(5f1d82ee) rgba(5f1d82ee) rgba(5f1d82ee) rgba(00c9a7ee)";
        "col.inactive_border" = "rgba(595959aa)";
      };

      decoration = {
        rounding = 3;

        blur = {
          size = 8;
          passes = 2;
        };
      };

      animation = {
        bezier = [
          "overshoot, 0.21, 0.82, 0.39, 1.3"
          "overshoot-light, 0.21, 0.82, 0.39, 1.11"

          "linear, 0, 0, 1, 1"
        ];

        animation = [
          "windows,    1, 4, overshoot, popin 80%"

          #"borderangle, 1, 10, linear, loop" # TODO fix unclean animation hyprland issue
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

        hyprshot-command = "${pkgs.hyprshot}/bin/hyprshot -o /tmp -f screenshot";
      in
        [
          "$mainMod, bracketleft, movecurrentworkspacetomonitor, eDP-1"
          "$mainMod, bracketright, movecurrentworkspacetomonitor, HDMI-A-1"

          "$mainMod, D, execr, ${pkgs.alacritty}/bin/alacritty"
          "$mainMod, W, execr, ${pkgs.alacritty}/bin/alacritty -e $EDITOR"
          "$mainMod, E, execr, ${pkgs.gnome.nautilus}/bin/nautilus -w"
          "$mainMod, Q, execr, ${config.programs.firefox.package}/bin/firefox"
          "$mainMod, A, execr, ${pkgs.gnome.gnome-calculator}/bin/gnome-calculator"
          "$mainMod, N, execr, ${pkgs.gnome-text-editor}/bin/gnome-text-editor"
          "$mainMod, I, execr, ${pkgs.gnome.eog}/bin/eog /tmp/screenshot"
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

          ",      PRINT, execr, ${hyprshot-command} -m output --current"
          "CTRL,  PRINT, execr, ${hyprshot-command} -m window"
          "SHIFT, PRINT, execr, ${hyprshot-command} -m region"

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
