# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      /etc/nixos/secrets.nix # Secrets that nobody should now
      ./flatpaks.nix
      ./zsh.nix
    ];

  options.options = {
    services.packagekit.enable = true;
  };

  # Bootloader.
  config = {
    boot = {
      loader.systemd-boot.enable = true;
      loader.efi.canTouchEfiVariables = true;
    };

    networking = {
      hostName = "ShiroPC"; # Define your hostname.
      # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

      # Configure network proxy if necessary
      # networking.proxy.default = "http://user:password@proxy:port/";
      # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

      # Enable networking
      networkmanager.enable = true;

      # Open KDEConnect ports
      firewall = {
        enable = true;
        allowedTCPPortRanges = [{ from = 1714; to = 1764; }];
        allowedUDPPortRanges = [{ from = 1714; to = 1764; }];
      };
    };

    # Set your time zone.
    time.timeZone = "America/Bogota";

    i18n = {
      # Select internationalisation properties.
      defaultLocale = "es_CO.UTF-8";
      extraLocaleSettings = {
        LC_ADDRESS = "es_CO.UTF-8";
        LC_IDENTIFICATION = "es_CO.UTF-8";
        LC_MEASUREMENT = "es_CO.UTF-8";
        LC_MONETARY = "es_CO.UTF-8";
        LC_NAME = "es_CO.UTF-8";
        LC_NUMERIC = "es_CO.UTF-8";
        LC_PAPER = "es_CO.UTF-8";
        LC_TELEPHONE = "es_CO.UTF-8";
        LC_TIME = "es_CO.UTF-8";
      };
    };

    services = {
      xserver = {
        # Enable the X11 windowing system.
        enable = true;

        # Configure keymap in X11
        layout = "latam";
        xkbVariant = "";

        # Enable the KDE Plasma Desktop Environment.
        displayManager.sddm.enable = true;
        desktopManager.plasma5.enable = true;
      };

      openssh = {
        enable = true;
      };

      packagekit.enable = true;

      # Enable CUPS to print documents.
      printing.enable = true;
    };

    nix = {
      settings = {
        # Optimise store
        auto-optimise-store = true;
        experimental-features = [ "nix-command" "flakes" ];
      };
      
      # Collect garbage older than 5 days
      gc = {
        automatic = true;
        dates = "daily";
        options = "--delete-older-than 5d";
      };
    };

    # run 'nix-env --delete-generations +5' to delete old generations and keep the 5 more recent
    systemd = {
      services.clean-old-nix-generations = {
        description = "Clean old nix generations";
        serviceConfig.Type = "oneshot";
        path = [ pkgs.nix ];
        script = "${pkgs.nix}/bin/nix-env --delete-generations +5";
      };
      timers.clean-old-nix-generations = {
        description = "Clean old nix generations";
        wantedBy = [ "timers.target" ];
        timerConfig.OnCalendar = "daily";
        timerConfig.Unit = "clean-old-nix-generations.service";
      };
    };

    # Configure console keymap
    console.keyMap = "la-latin1";


    # Enable sound with pipewire.
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.shiro = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      shell = pkgs.zsh;
      packages = with pkgs; [
        (pkgs.callPackage ./custom_packages/nix-nwjs/default.nix {
          sdk = true;
        })
      ];
    };

    # Programs
    programs = {
      steam.enable = true;
      gamemode.enable = true;
      nix-ld.enable = true;
      gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
        enableBrowserSocket = true;
        pinentryFlavor = "qt";
      };
      neovim = {
        enable = true;
        defaultEditor = true;
      };
    };

    virtualisation.docker.enable = true;

    fonts = {
      packages = with pkgs; [
        corefonts
        vistafonts
        (nerdfonts.override {
          fonts = [
            "VictorMono"
            "CascadiaCode"
          ];
        })
      ];
      fontDir.enable = true;
    };
    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      gh
      git
      file
      unrar
      htop
      wget
      zsh
      eza
      bat
      fzf
      neofetch
      python311
      libsForQt5.xdg-desktop-portal-kde
      libsForQt5.systemsettings
      libsForQt5.polkit-qt
      libsForQt5.polkit-kde-agent
      libsForQt5.packagekit-qt
      # No Dinamic Libraries on NixOS so I have to do the Dinamic part
      patchelf
      binutils
      stdenv
      nix-index
    ];

    hardware.opengl.enable = true;

    system.autoUpgrade.enable = true;

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.05"; # Did you read the comment?

  };
}
