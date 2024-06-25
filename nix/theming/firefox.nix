{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [unstable.pywalfox-native];

  # Disabled while this is broken
  # (don't want to replace my profiles.ini)

  #programs.firefox.profiles."default" = {
  #  settings.extensions.autoDisableScopes = 0;

  #  extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
  #    pywalfox
  #  ];
  #};

  programs.matugen.templates.firefox = {
    input_path = ../../external/templates/colors.json;
    output_path = "${config.xdg.cacheHome}/wal/colors.json";
  };
}
