{matugen, ...}: {
  imports = [matugen.nixosModules.default];

  programs.matugen.templates.gtk = {
    input_path = ../../external/templates/gtk.css;
    output_path = "~/.config/gtk-4.0/gtk.css";
  };
}
