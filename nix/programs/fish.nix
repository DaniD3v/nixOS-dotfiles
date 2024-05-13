{pkgs, ...}: {
  programs.fish = {
    plugins = with pkgs.fishPlugins; [
      {
        name = "z";
        src = z.src;
      } # fuzzy cd
      {
        name = "tide";
        src = tide.src;
      } # prompt
      {
        name = "done";
        src = done.src;
      } # notification after long commands
      {
        name = "sponge";
        src = sponge.src;
      } # removes failed commands from history
      {
        name = "puffer";
        src = puffer.src;
      } # '...' -> '../..' and '!!' -> <previous command>
      {
        name = "autopair";
        src = autopair.src;
      }
    ];

    shellAliases = {
      nmwifi = "${pkgs.networkmanager}/bin/nmcli device wifi";
      nmcn = "${pkgs.networkmanager}/bin/nmcli device wifi connect";
      btdcn = "${pkgs.bluez}/bin/bluetoothctl disconnect";
      btcn = "${pkgs.bluez}/bin/bluetoothctl connect";

      with-pkg = "${pkgs.nix}/bin/nix-shell --run fish -p";
      yoink = "${pkgs.git}/bin/git clone --depth 1 --recurse-submodules";
      bcomp = "${pkgs.gnutar}/bin/tar --use-compress-program='${pkgs.pigz}/bin/pigz -9' -cf compressed.tar.xz";

      yt-dlp-mp4 = "${pkgs.yt-dlp}/bin/yt-dlp f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'";
      yt-dlp-mp3 = "${pkgs.yt-dlp}/bin/yt-dlp -x --audio-format mp3 --audio-quality 0";
      zclippy = "${pkgs.rustup}/bin/cargo clippy -- -W clippy::complexity -W clippy::correctness -W clippy::perf -W clippy::style -W clippy::suspicious";

      nano = "${pkgs.neovim}/bin/nvim";
      cat = "${pkgs.bat}/bin/bat";
    };

    interactiveShellInit = ''
      set fish_greeting
      bind \b backward-kill-word
      fish_add_path ~/.local/bin  # TODO workaround because home.sessionPath isn't working.
    '';
  };
}
