{
  pkgs,
  stdenv,
  vars,
  ...
}:
let
  to_single_quote = s: "'${s}'";
  to_lua_list = ls: "{ ${builtins.concatStringsSep ", " (map to_single_quote ls)} }";
  lsps = (import ./lsps.nix) pkgs;
  buildLspConf = lsp: ''
    -- lsp conf for ${lsp.name}
    vim.lsp.config['${lsp.name}'] = {
    	cmd = ${to_lua_list lsp.cmd},
    	filetypes = ${to_lua_list lsp.filetypes},
    	root_markers = ${to_lua_list lsp.root_markers},
    	settings = {},
    }

    -- register lsp
    vim.lsp.enable('${lsp.name}')
        	'';
  main_config = ''
    -- general settings
    vim.lsp.config('*', {
      root_markers = { '.jj' }
    })

    -- autocompletion
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client:supports_method('textDocument/completion') then
          vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end
      end,
    })
        	'';
  lsp_conf_strings = map buildLspConf lsps;
  per_conf_strings = builtins.concatStringsSep "\n" lsp_conf_strings;
in
stdenv.mkDerivation {
  name = "nvim-lsp";
  src = null;
  dontUnpack = true;

  installPhase = ''
    	mkdir -p ${vars.config_dir}/nvim/lua

    	echo "${main_config}" > ${vars.config_dir}/nvim/lua/lsp.lua
    	echo "${per_conf_strings}" >> ${vars.config_dir}/nvim/lua/lsp.lua
  '';
}
