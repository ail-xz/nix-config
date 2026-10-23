{
  inputs,
  pkgs,
  config,
  ...
}:
{
  imports = [ inputs.nixvim.homeModules.nixvim ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # 評価時の警告を無くす
    nixpkgs.source = inputs.nixpkgs;

    opts = {
      number = true;
      relativenumber = true;
      ignorecase = true;
      smartcase = true;
      expandtab = true;
      shiftwidth = 2;
      softtabstop = -1;
    };

    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "mocha";
    };

    globals.mapleader = " ";

    clipboard.providers.wl-copy.enable = pkgs.stdenv.hostPlatform.isLinux;

    keymaps = [
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>y";
        action = ''"+y'';
        options.desc = "Yank to clipboard";
      }
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>p";
        action = ''"+p'';
        options.desc = "Paste from clipboard";
      }
    ];

    plugins = {
      lualine.enable = true;
      web-devicons.enable = true;
      which-key.enable = true;
      gitsigns.enable = true;
      nvim-autopairs.enable = true;
      render-markdown.enable = true;

      treesitter = {
        enable = true;
        highlight.enable = true;
        indent.enable = true;
      };

      hlchunk = {
        enable = true;
        settings = {
          chunk = {
            enable = true;
          };
          indent.enable = true;
        };
        # Nix Language
        luaConfig.pre = ''
          require("hlchunk.utils.ts_node_type").nix = {
            attrset_expression = true,
            rec_attrset_expression = true,
            let_attrset_expression = true,
            let_expression = true,
            list_expression = true,
            function_expression = true,
          }
        '';
      };

      lspconfig.enable = true;
      blink-cmp.enable = true;
    };

    lsp = {
      servers = {
        nixd = {
          enable = true;
          config.settings.nixd = {
            # <nixpkgs> が無いので flake の input を直接渡す
            nixpkgs.expr = "import ${inputs.nixpkgs} { }";
            options.home_manager.expr = ''(import ${inputs.home-manager}/modules { configuration = { home.stateVersion = "${config.home.stateVersion}"; }; pkgs = import ${inputs.nixpkgs} { }; }).options'';
            formatting.command = [ "nixfmt" ];
          };
        };
        taplo.enable = true;
        clangd.enable = true;
        basedpyright.enable = true;
        ruff.enable = true;
        yamlls.enable = true;
        jsonls.enable = true;
      };

      keymaps = [
        {
          key = "gd";
          lspBufAction = "definition";
        }
      ];
    };

    diagnostic.settings.virtual_text = true;

    extraPackages = [ pkgs.nixfmt ];
  };
}
