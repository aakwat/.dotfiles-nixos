{ ... }:
{
  # Memory-safe sudo. Rollback via the boot menu if it ever locks you out.
  security.sudo.enable = false;
  security.sudo-rs = {
    enable = true;
    execWheelOnly = true;
  };

  # An editable boot command line is local root (init=/bin/sh).
  boot.loader.systemd-boot.editor = false;

  # DoT (RFC 7858) + DNSSEC (RFC 4033). allow-downgrade: strict breaks
  # captive portals.
  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNSSEC = "allow-downgrade";
      DNSOverTLS = "true";
    };
  };
  networking.networkmanager.dns = "systemd-resolved";

  boot.kernel.sysctl = {
    "kernel.kptr_restrict" = 2;
    "kernel.dmesg_restrict" = 1;
    "net.ipv4.conf.all.rp_filter" = 1;
    "net.ipv4.conf.all.accept_redirects" = 0;
    "net.ipv6.conf.all.accept_redirects" = 0;
    # Not set: unprivileged_userns_clone=0 breaks the Chromium sandbox and
    # nix build sandboxing.
  };

  security.protectKernelImage = true;
  services.fwupd.enable = true;
}
