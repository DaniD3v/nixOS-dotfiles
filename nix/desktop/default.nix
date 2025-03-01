{pkgs, ...}: {
  imports = [
    ./hyprland.nix
    ./swaylock.nix
    ./swww.nix
  ];

  # this is a hack.
  # I will wrap this in hestia-bar later
  home.packages = [pkgs.adwaita-icon-theme];
}
