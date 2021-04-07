{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = [
    pkgs.glibcLocales
    pkgs.dotnet-sdk_3
    pkgs.jetbrains.rider
    pkgs.jetbrains.webstorm
    pkgs.jetbrains.datagrip
    pkgs.gitAndTools.gh
    pkgs.heroku
    pkgs.awscli2
    pkgs.ssm-session-manager-plugin
    pkgs.vscode
    pkgs.shellcheck
    pkgs.graphviz
    pkgs.postgresql_11
  ];

  shellHook = ''
    export DOTNET_CLI_TELEMETRY_OPTOUT=true
    export DOTNET_ROOT="$(dirname $(realpath $(which dotnet)))"
    export PATH=$PATH:$HOME/.dotnet/tools

    export HEROKU_ORGANIZATION=hackney-apps
    
    export AWS_PROFILE=h_dev
    export RPROMPT="%F{green}hackney(\$AWS_PROFILE)"
  '';
}
