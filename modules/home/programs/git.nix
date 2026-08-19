{ ... }:
{
  programs.git = {
    enable = true;

    settings = {
      user.name = "Aung Koko Lwin";
      user.email = "toyko2001@gmail.com";
      user.signingKey = "~/.ssh/coffee.pub";

      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;

      # Sign with the SSH key, not GPG.
      gpg.format = "ssh";
      commit.gpgSign = true;
      tag.gpgSign = true;

      transfer.fsckObjects = true;
      fetch.fsckObjects = true;
      receive.fsckObjects = true;
    };
  };
}
