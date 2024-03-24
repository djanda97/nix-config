{ config
, pkgs
, ...
}: {
  imports = [ ./hardware-configuration.nix ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "framework";
    networkmanager.enable = true;
  };

  time.timeZone = "America/Los_Angeles";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  services = {
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      layout = "us";
      xkbVariant = "";
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    printing = {
      enable = true;
    };
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  users.users.david = {
    isNormalUser = true;
    description = "David";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ firefox thunderbird ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    nnn
    helix
    kitty
    tailscale
    ripgrep
    fzf
    bat
    gnome.gnome-tweaks
    iosevka
    makemkv
    handbrake
    htop
    home-manager
    sysz
    manix
    nixfmt
    alejandra
    nixpkgs-fmt
  ];

  programs = { nix-ld = { enable = true; }; };

  services = { jellyfin = { enable = true; }; };

  system.stateVersion = "23.11";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
