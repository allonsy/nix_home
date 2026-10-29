inputs@{
  pkgs,
  stdenv,
  vars,
  ...
}:
let
  rsync = "${pkgs.rsync}/bin/rsync";
  buildGrammar' = import ./buildGrammar.nix;
  buildGrammar = conf: buildGrammar' (inputs // conf);
  grammarConfigs = builtins.fromJSON (builtins.readFile ./languages.json);
  grammars = map buildGrammar grammarConfigs;
  lsps = (import ./lsp.nix) inputs;
  config_dir = "${vars.config_dir}/nvim";
  base_treesitter_config = ''
    -- autostart treesitter on available grammars
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
        if lang and vim.treesitter.language.add(lang) then
          vim.treesitter.start(args.buf, lang)
        end
      end,
    })
  '';
in
pkgs.symlinkJoin {
  name = "nvim-languages";
  paths = grammars ++ [ lsps ];

  postBuild = ''

      mkdir -p ${config_dir}/lua

      echo "${base_treesitter_config}" >> ${config_dir}/lua/tree-sitter.lua

      cat ${config_dir}/register_*.lua >> ${config_dir}/lua/tree-sitter.lua
      rm ${config_dir}/register_*.lua
    	
  '';
}
