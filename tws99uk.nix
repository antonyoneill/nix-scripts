let
  pkgs = import <nixpkgs> {};
  stdenv = pkgs.stdenv;
  phpIni = pkgs.runCommand "php.ini"
  { options = ''
      memory_limit = -1
	  zend_extension=${pkgs.php74Extensions.xdebug}/lib/php/extensions/xdebug.so
	  max_execution_time = 0
	  xdebug.remote_autostart = 1
	  xdebug.remote_enable = 1
	  xdebug.log="/tmp/xdebug.log"
	  xdebug.remote_log="/tmp/remote_xdebug.log"
    '';
  }
  ''
    cat "${pkgs.php}/etc/php.ini" > $out
    echo "$options" >> $out
  '';
  phpOverride = stdenv.mkDerivation rec {
    name = "php-with-custom-ini";
    buildInputs = [
      pkgs.makeWrapper
      pkgs.php
      pkgs.php74Extensions.xdebug
    ];
    buildCommand = ''
      makeWrapper ${pkgs.php}/bin/php $out/bin/php --add-flags -c --add-flags "${phpIni}"
    '';
  };
in
stdenv.mkDerivation {
  name = "tws99uk";
  buildInputs = [
    pkgs.jetbrains.phpstorm
    pkgs.gitAndTools.gh
    pkgs.nodejs-10_x
    pkgs.nodePackages.yarn
    phpOverride
    pkgs.php74Packages.composer
  ];

  shellHook = ''
    export WORK_ORG=tws99
    export RPROMPT="%F{red}$WORK_ORG"

    export PATH="$(yarn global bin):$PATH"
    export PATH="$HOME/.symfony/bin:$PATH"

  '';
}
