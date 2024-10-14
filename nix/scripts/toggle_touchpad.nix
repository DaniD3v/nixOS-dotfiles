{config, ...}: {
  home.file.".local/bin/toggle_touchpad" = let
    file = "/tmp/touchpad_disabled";
    command = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl keyword device[asue120a:00-04f3:319b-touchpad]:enabled";
  in {
    text = ''
      #!/bin/sh

      if [ -f "${file}" ]; then
        ${command} true
        rm "${file}"
      else
        ${command} false
        touch "${file}"
      fi
    '';

    executable = true;
  };
}
