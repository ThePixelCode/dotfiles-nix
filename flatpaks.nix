{config, pkgs, ...}:

{
  config.services.flatpak = {
    # Flatpak
    enable = true;
    deduplicate = true;
    packages = [
      "flathub:apps/com.brave.Browser/x86_64/stable"
    ];
  };
}