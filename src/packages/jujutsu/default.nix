{
  pkgs,
  stdenv,
  vars,
  ...
}:
let
  email = if vars.isLinux then "linuxbash8@gmail.com" else "alec.snyder@at-bay.com";
in
stdenv.mkDerivation {
  name = "jujutsu";
  src = ./.;

  installPhase = ''
    mkdir -p $out/etc/config/jj
    mkdir -p $out/bin
    mkdir -p $out/share/zsh/site-functions

    cat <<EOF > $out/etc/config/jj/config.toml
    [user]
    name = "Alec Snyder"
    email = "${email}"

    EOF

    cat config.toml >> $out/etc/config/jj/config.toml
    cp ${pkgs.jujutsu}/bin/jj $out/bin/jj
    cp ${pkgs.jujutsu}/share/zsh/site-functions/_jj $out/share/zsh/site-functions/_jj
  '';
}
