{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = [
    pkgs.dotnet-sdk_3
    pkgs.jetbrains.rider
    pkgs.jetbrains.webstorm
    pkgs.jetbrains.datagrip
    pkgs.gitAndTools.gh
    pkgs.heroku
    pkgs.awscli2
    pkgs.ssm-session-manager-plugin
  ];

  shellHook = ''
    export DOTNET_CLI_TELEMETRY_OPTOUT=true
    export DOTNET_ROOT=$(dirname $(realpath $(which dotnet)))
    export PATH=$PATH:/home/antony/.dotnet/tools

    export AWS_PROFILE=a_dev
    export WORK_ORG=ant
    export RPROMPT="%F{green}$WORK_ORG($AWS_PROFILE)"

    if [[ "$(dotnet tool list -g|grep amazon.lambda.tools | wc -l)" -eq 0 ]]
    then
      dotnet tool install -g Amazon.Lambda.Tools
    fi

    if [[ "$(dotnet new --list |grep AWS/Lambda | wc -l)" -eq 0 ]]
    then
      dotnet new --install Amazon.Lambda.Templates::4.2.0
    fi
  '';
}
