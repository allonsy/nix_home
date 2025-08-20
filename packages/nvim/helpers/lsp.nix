# language specific definitions for lsp servers
# the key is the name of the language
# conf: optional string identifying the name of the section in nvim-lspconfig repo
# pkg: optional string identifying the name of the package in nixpkgs to install for the lsp
{
  lua = {
    conf = "lua_ls";
    pkg = "lua-language-server";
  };
  rust = {
    conf = "rust_analyzer";
  };
  python = {
    conf = "ruff";
    pkg = "ruff";
  };
}
