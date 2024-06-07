{pkgs, ...}: let
  package = pkgs.swww;
in {
  home.packages = [package];

  systemd.user.services.swww = {
    Unit = {
      Description = "Wallpaper daemon";
      Documentation = ["man:swww-daemon(1)"];

      Requires = ["graphical-session.target"];
    };

    Service = {
      Type = "notify";

      Environment = "XDG_RUNTIME_DIR=/run/user/%U";
      ExecStart = "${package}/bin/swww-daemon";
    };

    Install.WantedBy = ["graphical-session.target"];
  };
}
