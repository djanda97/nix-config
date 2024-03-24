{ inputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    # inputs.nix-colors.homeManagerModule
  ];

  nixpkgs = {
    overlays = [ ];
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
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

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
