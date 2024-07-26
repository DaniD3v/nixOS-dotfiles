{pkgs, ...}: {
  programs.helix = {
    defaultEditor = true;
    
    extraPackages = with pkgs; [
      rust-analyzer
      nil
    ];

    languages = {
      language-server = {
        rust-analyzer.config = {
          rustc.source = "discover"; # make rustc internal crates work
          check.command = "${pkgs.clippy}/bin/clippy";
        };
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
