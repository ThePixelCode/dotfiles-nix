{config, pkgs, ...}:

{
  config.services.flatpak = {
    # Flatpak
    enable = true;
    deduplicate = true;
    packages = [
      "flathub:app/com.brave.Browser/x86_64/stable"
    ];
  };
}