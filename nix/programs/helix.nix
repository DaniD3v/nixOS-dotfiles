{pkgs, ...}: {
  programs.helix = {
    defaultEditor = true;
    
    extraPackages = with pkgs; [
      rust-analyzer
      nil
    ];

    languages = {
      language-server = {
        rust-analyzer.config.check.command = "${pkgs.clippy}/bin/clippy";
      };

      language = [
        {
          name = "nix";
          formatter.command = "${pkgs.alejandra}/bin/alejandra";
        }
      ];
    };
  };
}
