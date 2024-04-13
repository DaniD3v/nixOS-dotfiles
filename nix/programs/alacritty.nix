{pkgs, ...}: {
  programs.alacritty.settings = {
    font.normal = {
      family = "MesloLGSNF";
      style = "Regular";
    };

    window = {
      padding = { x = 5; y = 5; };
      opacity = 0.5;
    };
  };

  home.packages = with pkgs; [meslo-lgs-nf];
}
