{ inputs
, lib
, config
, pkgs
, ...
}: {
  imports = [ ];

  nixpkgs = {
    overlays = [ ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    stateVersion = "23.11";
    username = "david";
    homeDirectory = "/home/david";
    packages = with pkgs; [
      steam
    ];
  };

  programs = {
    fish = {
      enable = true;
    };

    home-manager = {
      enable = true;
    };

    git = {
      enable = true;
      userName = "David Janda";
      userEmail = "djanda97@gmail.com";
    };

    neovim = {
      enable = true;
    };

    vscode = {
      enable = true;
      package = pkgs.vscodium;
      extensions = with pkgs.vscode-extensions; [
        catppuccin.catppuccin-vsc
        jnoortheen.nix-ide
        vscodevim.vim
      ];
    };
  };

  systemd.user.startServices = "sd-switch";
}
