{
  pkgs,
  lib,
  ...
}: {
  programs.helix = {
    defaultEditor = true;

    settings = {
      theme = "ayu_mirage";
      # theme = "base16_transparent";

      editor = {
        indent-guides.render = true;
        cursor-shape.insert = "bar";

        completion-trigger-len = 0;
      };

      keys = let
        makeRunCommands = bind: command: {
          normal = {
            "A-r" = {${bind} = ":sh ${command} 2>&1 | cat";};
            "C-r" = {${bind} = [":vnew" ":insert-output ${command} 2>&1 | cat" "goto_file_start"];};
          };
        };
      in
        lib.mkMerge [
          {
            # Make `x` not skip an empty newline
            normal.x = ["extend_to_line_bounds" "select_mode"];
            select.x = ["extend_line"];

            # Automatically go into normal mode in order
            # to make x behavior consistent with original
            select.";" = ["collapse_selection" "normal_mode"];

            # Select whole line except for whitespace characters.
            # ()`X` is obsolete because it is the exact
            # same thing `x` does on the first keypress.)
            normal.X = ["goto_first_nonwhitespace" "extend_to_line_end"];
            select.X = "extend_to_line_end";
          }

          # Minor mode for running cargo commands
          (makeRunCommands "r" "cargo run")
          (makeRunCommands "t" "cargo test")
        ];
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
          language-servers = ["pyright"];
        }
      ];
    };
  };
}
