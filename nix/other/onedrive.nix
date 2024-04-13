{pkgs, ...}: {
  systemd.user.services.onedrive = {
    Unit = {
      Description = "Mounts Onedrive storage";
      Documentation = ["man:rclone(1)"];

      Requires = ["network-online.target"];
    };

    Service = {
      Type = "notify";
      Environment = ["PATH=/run/wrappers/bin:$PATH"];

      Restart = "on-failure";
      RestartSec = 30;

      ExecStartPre = "-${pkgs.coreutils}/bin/mkdir -p %h/onedrive";
      ExecStart = ''
        ${pkgs.rclone}/bin/rclone mount \
            --config=${../../secrets/rclone.conf} \
            --vfs-cache-mode full \
            --vfs-cache-max-age 1y \
            onedrive: %h/onedrive
      '';
      ExecStop = "${pkgs.fuse}/bin/fusermount -u %h/onedrive";
    };

    Install.WantedBy = ["network-online.target"];
  };
}
