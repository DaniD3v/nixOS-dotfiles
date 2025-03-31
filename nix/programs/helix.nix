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
          (makeRunCommands "t" "cargo test --workspace")
        ];
    };

    extraPackages = with pkgs; [
      angular-language-server
      pyright
      sqls
      nil

      (import ./rust-toolchain.nix pkgs)
      taplo # toml lsp

      omnisharp-roslyn
      csharpier

      nodePackages.typescript-language-server
      nodePackages.prettier

      (buildNpmPackage rec {
        pname = "greybel-languageserver";
        version = "1.14.0";

        src = fetchFromGitHub {
          owner = "ayecue";
          repo = pname;
          rev = "f8e0eb41e84c2af71affa3fc54ef6dd7f6989e60";
          hash = "sha256-ibhqOLN/T8qivR7F1t9d3YrBjMTRbAHDI9aqYDfhdmY=";
        };
        sourceRoot = "source/packages/node";

        npmDepsHash = "sha256-qu7T/mXyA8PYdCnye3t0Ix1nC1zAopcNFkNxtUhHqIg=";
      })
    ];

    languages = {
      language-server = {
        rust-analyzer.config = {
          # rustc.source = "discover"; # make rustc internal crates work
          check.command = "clippy";
        };
        greybel-lsp = {
          command = "greybel-languageserver";
          args = ["--stdio"];
        };
        angular-lsp = {
          command = "ngserver";
          args = ["--stdio"];

          roots = ["angular.json"];
        };
        sqls.command = "sqls";
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
        {
          name = "sql";
          language-servers = ["sqls"];
        }
        {
          name = "greyscript";
          scope = "source.greyscript";

          file-types = ["gs" "ms" "src"];
          language-servers = ["greybel-lsp"];
        }

        {
          name = "html";
          language-servers = ["angular-lsp" "vscode-html-language-server"];
        }
        {
          name = "typescript";
          language-servers = ["typescript-language-server" "angular-lsp"];
        }
      ];
    };
  };
}
