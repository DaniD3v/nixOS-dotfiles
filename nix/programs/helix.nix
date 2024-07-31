{pkgs, ...}: {
  programs.helix = {
    defaultEditor = true;

    settings = {
      theme = "jetbrains_dark";
      # theme = "base16_transparent";
      
      editor = {
        indent-guides.render = true;
        cursor-shape.insert = "bar";

        completion-trigger-len = 0;
      };
    };
    
    extraPackages = with pkgs; [
      rust-analyzer
      pyright
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
        {
          name = "python";
          language-servers = [ "pyright" ];
        }
      ];
    };
  };
}
