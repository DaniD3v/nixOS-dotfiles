{pkgs, ...}: {
  home.file.".local/bin/wal" = {
    text = ''
      #!/bin/sh

      set -eu
      wallpaper=$(${pkgs.coreutils}/bin/readlink -f "$1")
      export XDG_RUNTIME_DIR=/run/user/''${UID} # use right swww socket

      ${pkgs.swww}/bin/swww img ''${wallpaper} -t grow --transition-pos 0.7,0.9
      ${pkgs.matugen}/bin/matugen image ''${wallpaper} 1>/dev/null
      PRIMARY_COLOR=$(${pkgs.matugen}/bin/matugen image ''${wallpaper} --json strip | ${pkgs.jq}/bin/jq ".colors.light.primary" | ${pkgs.coreutils}/bin/tr -d '"')

      ${pkgs.pywalfox-native}/bin/pywalfox update 2>/dev/null
      asusctl led-mode static -c "$PRIMARY_COLOR" # asusctl is installed system-wide so I can't use an absolute path.
    '';

    executable = true;
  };
}
