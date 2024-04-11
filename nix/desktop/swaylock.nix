{pkgs, ...}: {
  # requires `security.pam.services.swaylock = {}` in configuration.nix
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;

    settings = {
      ignore-empty-password = true;
      screenshots = true;

      indicator = true;
      clock = true;

      effect-vignette = "0.8:0.3";
      effect-blur = "4x6";
    };
  };

  services.swayidle = {
    enable = true;

    timeouts = [
      {
        command = "${pkgs.brightnessctl}/bin/brightnessctl -s set 5%";
        resumeCommand = "${pkgs.brightnessctl}/bin/brightnessctl -r";
        timeout = 270;
      }
      {
        command = "${pkgs.swaylock-effects}/bin/swaylock -f --grace 30; ${pkgs.systemd}/bin/systemctl suspend";
        timeout = 300;
      }
    ];
  };
}
