{matugen, ...}: {
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  programs.matugen.templates.gtk = {
    input_path = ../../external/templates/gtk.css;
    output_path = "~/.config/gtk-4.0/gtk.css";
  };
}
