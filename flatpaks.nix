{ config, pkgs, ... }:

{
  config.services.flatpak = {
    # Flatpak
    enable = true;
    deduplicate = true;
    packages = [
      "flathub:app/com.brave.Browser/x86_64/stable"
      "flathub:app/com.github.tchx84.Flatseal/x86_64/stable"
      "flathub:app/com.bitwarden.desktop/x86_64/stable"
      "flathub:app/com.discordapp.Discord/x86_64/stable"
      "flathub:app/org.telegram.desktop/x86_64/stable"
      "flathub:app/com.ktechpit.whatsie/x86_64/stable"
      "flathub:app/com.ktechpit.torrhunt/x86_64/stable"
      "flathub:app/org.libreoffice.LibreOffice/x86_64/stable"
    ];
    remotes = {
      "flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    };
  };
}