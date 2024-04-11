{
  ags,
  pkgs,
  ...
}: {
  imports = [ags.homeManagerModules.default];

  programs.ags = {
    enable = true;

    configDir = ../../external/ags;
  };

  home.packages = with pkgs.gnome; [adwaita-icon-theme];
}