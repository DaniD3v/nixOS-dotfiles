{pkgs, ...}: {
  imports = [
    ./swaylock.nix
    ./ags.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
  };

  xdg.configFile."hypr" = {
    source = ../../external/hypr;
    recursive = true;
  };

  # Required packages for the config to work
  home.packages = with pkgs; [
    hyprpaper

    brightnessctl
    playerctl

    # screenshots
    wl-clipboard
    slurp
    grim
  ];
}
