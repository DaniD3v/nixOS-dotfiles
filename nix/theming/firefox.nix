{
  pkgs,
  config,
  ...
}:
with pkgs;
with python3Packages; let
  pywalfox = buildPythonPackage {
    pname = "pywalfox";
    version = "2.8.0rc1";

    src = fetchFromGitHub {
      owner = "Frewacom";
      repo = "pywalfox-native";
      rev = "7ecbbb193e6a7dab424bf3128adfa7e2d0fa6ff9";
      hash = "sha256-i1DgdYmNVvG+mZiFiBmVHsQnFvfDFOFTGf0GEy81lpE=";
    };
  };
in {
  home.packages = [pywalfox];

  programs.matugen.templates.firefox = {
    input_path = ../../external/templates/colors.json;
    output_path = "${config.xdg.cacheHome}/wal/colors.json";
  };
}
