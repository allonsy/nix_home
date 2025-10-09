pkgs:
  let
    awsNoTests = pkgs.awscli2.overrideAttrs {
      pytestCheckPhase = "echo 'Skipping pytestCheckPhase for awscli'";
    };
  in
    with pkgs; [
      awsNoTests
      dapr-cli
      jdk23
      k9s
      kubectl
      stow
      tfswitch
      tgswitch
    ]
