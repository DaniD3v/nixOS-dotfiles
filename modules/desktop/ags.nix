{ags, ...}: {
  imports = [ags.homeManagerModules.default];

  programs.ags = {
    enable = true;

    configDir = ../../external/ags;
  };
}
