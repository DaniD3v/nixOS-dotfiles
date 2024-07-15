{pkgs, ...}: {
  programs.fish = {
    plugins = with pkgs.fishPlugins; [
      {
        name = "z";
        inherit (z) src;
      } # fuzzy cd
      {
        name = "tide";
        inherit (tide) src;
      } # prompt
      {
        name = "done";
        inherit (done) src;
      } # notification after long commands
      {
        name = "sponge";
        inherit (sponge) src;
      } # removes failed commands from history
      {
        name = "puffer";
        inherit (puffer) src;
      } # '...' -> '../..' and '!!' -> <previous command>
      {
        name = "autopair";
        inherit (autopair) src;
      }
    ];

    functions = {
      nr = "${pkgs.nix}/bin/nix run nixpkgs#$argv[1] -- $argv[2..-1]";
      ni = "${pkgs.nix}/bin/nix shell nixpkgs#$argv[1]";
    };

    shellAliases = {
      ns = "${pkgs.nix}/bin/nix search nixpkgs";

      btdcn = "${pkgs.bluez}/bin/bluetoothctl disconnect";
      btcn = "${pkgs.bluez}/bin/bluetoothctl connect";

      yoink = "${pkgs.git}/bin/git clone --depth 1 --recurse-submodules";
      bcomp = "${pkgs.gnutar}/bin/tar --use-compress-program='${pkgs.pigz}/bin/pigz -9' -cf compressed.tar.xz";

      yt-dlp-mp4 = "${pkgs.yt-dlp}/bin/yt-dlp f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'";
      yt-dlp-mp3 = "${pkgs.yt-dlp}/bin/yt-dlp -x --audio-format mp3 --audio-quality 0";
      zclippy = "${pkgs.rustup}/bin/cargo clippy -- -W clippy::complexity -W clippy::correctness -W clippy::perf -W clippy::style -W clippy::suspicious";

      cat = "${pkgs.bat}/bin/bat";
    };

    interactiveShellInit = ''
      set fish_greeting
      bind \b backward-kill-word

      fish_add_path ~/.local/bin  # TODO workaround because home.sessionPath isn't working.
    '';
  };
}
