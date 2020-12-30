
{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = [
    pkgs.jetbrains.webstorm
    pkgs.gitAndTools.gh
    pkgs.nodejs-10_x
    pkgs.nodePackages.yarn
    pkgs.php
  ];

  shellHook = ''
    export WORK_ORG=tws99
    export RPROMPT="%F{red}$WORK_ORG"

    export PATH="$(yarn global bin):$PATH"
    export PATH="$HOME/.symfony/bin:$PATH"

  '';
}
