pkgs: [
  {
    name = "ty";
    cmd = [
      "${pkgs.ty}/bin/ty"
      "server"
    ];
    filetypes = [ "python" ];
    root_markers = [
      "pyproject.toml"
      "setup.py"
      "requirements.txt"
    ];
  }
  {
    name = "ruff";
    cmd = [
      "${pkgs.ruff}/bin/ruff"
      "server"
    ];
    filetypes = [ "python" ];
    root_markers = [
      "pyproject.toml"
      "setup.py"
      "requirements.txt"
    ];
  }
  {
    name = "rust-analyzer";
    cmd = [
      "${pkgs.rust-analyzer}/bin/rust-analyzer"
    ];
    filetypes = [ "rust" ];
    root_markers = [
      "Cargo.toml"
    ];
  }
]
