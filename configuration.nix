# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      ./fprintd.nix
      ./fonts.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = "999999999";
    "fs.inotify.max_queued_events" = "999999999";
    "fs.inotify.max_user_instances" = "999999999";
  };

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.wlp0s20f3.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "ja_JP.UTF-8/UTF-8";
  i18n.supportedLocales = [
    "C.UTF-8/UTF-8"
    "ja_JP.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
  ];
  i18n.inputMethod.enabled = "fcitx5";
  i18n.inputMethod.fcitx5.addons = with pkgs; [
    fcitx5-gtk
    fcitx5-mozc
  ];
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];


  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.displayManager.gdm.debug = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  programs.xss-lock = {
    enable = true;
    lockerCommand = "${pkgs.xautolock}/bin/xautolock -locknow";
  };
  services.xserver.xautolock = {
    time = 5;
    enable = true;
    locker = "${pkgs.xsecurelock}/bin/xsecurelock";
  };
  

  # Configure keymap in X11
  # services.xserver.layout = "us";
  services.xserver.xkbOptions = "ctrl:nocaps";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  hardware.pulseaudio.enable = false;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sei = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "vboxusers" ]; # Enable ‘sudo’ for the user.
    shell = "/run/current-system/sw/bin/zsh";
  };


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    _1password-gui
    _1password
    android-studio
    # TODO: move to kitty
    alacritty
    azure-cli
    bundix
    colordiff
    google-chrome
    delta
    direnv
    docker-compose
    easyeffects
    emacs
    firefox
    gh
    ghq
    gimp
    git
    gnomeExtensions.appindicator
    gnome.gnome-sound-recorder
    gnome.gnome-tweaks
    heroku
    home-manager
    hub
    jq
    jwt-cli
    k9s
    keybase-gui
    kitty
    kitty-themes
    kubectl
    kubelogin
    libreoffice
    lm_sensors
    microsoft-edge
    nix-prefetch-scripts
    nodejs
    obs-studio
    peco
    (callPackage ./pict.nix {})
    pixcat
    rcm
    ruby
    slack
    tig
    unar
    unzipNLS
    # TODO: move to zellij
    tmux
    (callPackage ./trdsql.nix {})
    vim
    vscode
    wineWowPackages.stable
    wineWowPackages.fonts
    winetricks
    xclip
    xorg.xmodmap
    xsecurelock
    xsensors
    zellij
    zoom-us
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.zsh.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "gnome3";
  };
  programs.wireshark.enable = true;
  programs.wireshark.package = pkgs.wireshark-qt;

  # List services that you want to enable:
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  
  # YubiKey smartcard mode
  services.pcscd.enable = true;

  services.kbfs.enable = true;
  services.keybase.enable = true;

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

  virtualisation = {
    docker.enable = true;
    virtualbox.host.enable = true;
    virtualbox.host.enableExtensionPack = true;
  };
}

