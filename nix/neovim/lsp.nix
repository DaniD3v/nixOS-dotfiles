{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      
      cmp-nvim-lsp
      nvim-cmp
      
      conform-nvim
    ];

    extraPackages = with pkgs; [
      rust-analyzer
      nixd
      
      alejandra
    ];

    extraLuaConfig = ''
      lspConfig = require("lspconfig")
      cmp = require("cmp")

      lspConfig.rust_analyzer.setup{}
      lspConfig.nixd.setup{}

      cmp.setup {
        sources = {
          { name = "nvim_lsp" }
        },
        mapping = {
          ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),

          ['<C-Space>'] = cmp.mapping({
            i = function(fallback)
              if cmp.visible() then
                cmp.confirm({ select = true })
              else
                cmp.complete()
              end
            end,
          }),
          ['<C-e>'] = cmp.mapping.abort(),
        },
      }

      require("conform").setup({
        formatters_by_ft = {
          nix = { "alejandra" },
        },
      })
    '';
  };
}
