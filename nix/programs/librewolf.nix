_: {
  programs.librewolf.settings = {
    # make lightmode work
    "privacy.resistFingerprinting" = false;

    "privacy.clearOnShutdown.history" = false;
    "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;

    # make websites like google that check for browsers work
    "general.useragent.compatMode.firefox" = true;
  };
}
