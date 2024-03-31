{
  system,
  matugen,
  ...
}: {
  imports = [matugen.nixosModules.default];

  programs.matugen = {
    enable = true;

    # This doesn't exist rn but I'll add it to upstream
    # settings = {
    #   config = {
    #     reload_apps = true;
    #     reload_apps_list = {
    #       gtk_theme = true;
    #       kitty = true;
    #       dunst = true;
    #     };
    #   };
    # };
  };

  home.packages = [matugen.packages.${system}.default];
}
