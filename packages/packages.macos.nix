pkgs:
  let
  in
    with pkgs; [
      awscli2
      dapr-cli
      jdk23
      k9s
      kubectl
      stow
      tfswitch
      tgswitch
    ]
