{pkgs, ...}: {
  systemd.user.services.swww = {
    Unit = {
      Description = "Wallpaper daemon";
      Documentation = ["man:swww-daemon(1)"];

      Requires = ["graphical-session.target"];
    };

    Service = {
      Type = "notify";
      ExecStart = "${pkgs.unstable.swww}/bin/swww-daemon";
    };
  
  Install.WantedBy = ["graphical-session.target"];
  };
}
