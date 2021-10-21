{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = [
    pkgs.gitAndTools.gh
    pkgs.awscli2
    pkgs.ssm-session-manager-plugin
    pkgs.terraform_0_13
    pkgs.jdk11_headless
  ];

  shellHook = ''
    export WORK_ORG=ant
    export RPROMPT="%F{blue}$WORK_ORG"
  '';
}
