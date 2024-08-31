{...}: {
  programs.librewolf.settings = {
    "privacy.resistFingerprinting" = false; # make lightmode work
    "privacy.clearOnShutdown.history" = false;
  };
}
