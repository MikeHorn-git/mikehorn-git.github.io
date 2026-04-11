{ pkgs, ... }:

{
  # https://devenv.sh/packages/
  packages = with pkgs; [ git hugo ];

  # https://devenv.sh/scripts/
  scripts = {
    "server:run".exec = ''
      hugo server --cleanDestinationDir --minify --disableFastRender
    '';
  };

  # https://devenv.sh/basics/
  enterShell = ''
    echo "Available commands:"
    echo " - server       : Local Hugo server"
  '';

  enterTest = ''
    hugo version
  '';

  # https://devenv.sh/git-hooks/
  git-hooks.hooks = {
    action-validator.enable = true;
    actionlint.enable = true;
    markdownlint.enable = true;
    nixfmt-classic.enable = true;
    prettier.enable = true;
    trim-trailing-whitespace.enable = true;
  };

  # See full reference at https://devenv.sh/reference/options/
}
