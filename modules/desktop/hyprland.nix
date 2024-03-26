{pkgs, ...}: {
  imports = [
    ./swaylock.nix
    ./ags.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
  };

  home.packages = [pkgs.hyprpaper];

  xdg.configFile."hypr" = {
    source = ../../external/hypr;
    recursive = true;
  };
}
