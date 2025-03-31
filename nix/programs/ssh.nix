_: {
  programs.ssh = {
    matchBlocks = {
      "danidev.vip" = {
        identityFile = "~/.secrets/ssh/server";
        user = "notyou";
      };

      "github.com" = {
        identityFile = "~/.secrets/ssh/github";
        user = "git";
      };
      "aur.archlinux.org" = {
        identityFile = "~/.secrets/ssh/aur";
        user = "aur";
      };
    };
  };
}
