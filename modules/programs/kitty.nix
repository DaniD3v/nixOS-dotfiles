{pkgs, ...}: {
  programs.kitty = {
    font.name = "MesloLGSNerdFont";
    font.package = pkgs.meslo-lgs-nf;

    settings = {
      window_padding_width = 2;

      background = "#000000";
      background_opacity = "0.7";
    };
  };
}
