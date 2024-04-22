{
  inputs,
  system,
  ...
}: {
  imports = [inputs.matugen.nixosModules.default];

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

  # https://github.com/InioX/matugen/issues/60
  xdg.configFile."matugen/config.toml".source = ../../external/matugen.toml;

  home.packages = [inputs.matugen.packages.${system}.default];
}
