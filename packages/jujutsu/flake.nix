{
  description = "jujutsu";

  inputs = {
  };

  outputs =
    {
      self,
    }:
    {
      package =
        system: pkgs:
        let
          email = if system.isLinux then "linuxbash8@gmail.com" else "alec.snyder@at-bay.com";
        in
        pkgs.stdenv.mkDerivation {
          name = "jujutsu";
          src = ./.;

          installPhase = ''
            mkdir -p $out/usr/config/jj
            mkdir -p $out/bin
            mkdir -p $out/share/zsh/site-functions

            cat <<EOF > $out/usr/config/jj/config.toml
            [user]
            name = "Alec Snyder"
            email = "${email}"

            EOF

            cat config.toml >> $out/usr/config/jj/config.toml
            cp ${pkgs.jujutsu}/bin/jj $out/bin/jj
            cp ${pkgs.jujutsu}/share/zsh/site-functions/_jj $out/share/zsh/site-functions/_jj
          '';
        };
    };
}
