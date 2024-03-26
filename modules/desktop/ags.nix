{inputs, ...}: {
  imports = [inputs.ags.homeManagerModules.default];

  programs.ags = {
    enable = true;

    configDir = ../../external/ags;
  };
}
