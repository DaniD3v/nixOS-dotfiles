{pkgs, ...}: {
  imports = [
    ./swaylock.nix
    ./swww.nix
    ./ags.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.unstable.hyprland;
  };

  xdg.configFile."hypr/hyprland.conf".source = ../../external/hyprland.conf;

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
