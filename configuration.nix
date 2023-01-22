{ config, pkgs, lib, ... }: {

  imports = [
    ./hardware-prometheus.nix
    ./containers.nix
    ./modules.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  nixpkgs.config.allowUnfree = true;


  time.timeZone = "Pacific/Auckland";
  i18n.defaultLocale = "en_NZ.UTF-8";
  console = {
    font   = "Lat2-Terminus16";
    keyMap = "us";
  };

  services.openssh = {
    enable = true;
    permitRootLogin = "no";
  };

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  users = {
    mutableUsers = false;
    users = {
      "root" = {
        hashedPassword = "$6$l/J3ViVWEbajlMzH$4h70CEggZDONSIPL6gvR2f.9UlgUXYSqDk5Ou0JH5ZpSp87a2Q68kWwB5vw35tS8zaCy5OLOwTSKk4qwL6FWz/";
      };
      "tzrlk" = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" ];
        hashedPassword = "$6$aH7aw9BTd2D3H6mC$JkzHgh64edJBJZWDPKgiEl9Rj42dB676XUMyfZHX6WuSxfJ1H62x7vZBfcJbV7HiVTXzxVARQ9C5QhgTJop16.";
        packages = with pkgs; [
          jetbrains.idea-ultimate
        ];
      };
    };
  };
  # TODO: user for media? docker?

  # $ nix search wget
  environment.systemPackages = with pkgs; [
    aria
    #displaylink
    git
    ranger # file browser
    ncdu  # filesystem usage
    nginx
    nixos-option
    nload # network monitoring
    vim
    vimPlugins.nginx-vim
    vimPlugins.ranger-vim
    vimPlugins.vim-nix
    vimPlugins.vim-pathogen
    wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  #programs.gnupg.agent = {
  #  enable = true;
  #  enableSSHSupport = true;
  #};

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}
