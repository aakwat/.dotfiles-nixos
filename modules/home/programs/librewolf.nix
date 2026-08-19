{ ... }:
{
  programs.librewolf = {
    enable = true;

    settings = {
      "privacy.resistFingerprinting" = true;
      # RFP otherwise forces light; this lets dark through.
      "ui.systemUsesDarkTheme" = 1;
      "browser.theme.content-theme" = 0;
      "browser.theme.toolbar-theme" = 0;

      # LibreWolf wipes cookies on exit by default — that is the re-login.
      "privacy.sanitize.sanitizeOnShutdown" = false;
      "privacy.clearOnShutdown.cookies" = false;
      "privacy.clearOnShutdown.sessions" = false;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.offlineApps" = false;
      "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
      "privacy.clearOnShutdown_v2.historyFormDataAndDownloads" = false;
      "network.cookie.lifetimePolicy" = 0;

      "browser.startup.page" = 3; # restore last session
    };
  };
}
