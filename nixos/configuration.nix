# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Ho_Chi_Minh";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
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

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
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

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.thai = {
    isNormalUser = true;
    description = "Thai Le";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
      pciutils
      git
      curl
      unzip
      procps
      cmake
      gcc
      gnupg
      autoconf
      home-manager
      ntfs3g
      wget
      gnumake
      zlib
      libffi
      readline
      bzip2
      openssl
      ncurses
      pyenv

      # CUDA and OpenGL
      cudatoolkit
      libGLU libGL
      xorg.libXi xorg.libXmu freeglut
      xorg.libXext xorg.libX11 xorg.libXv xorg.libXrandr zlib
      ncurses5
      stdenv.cc
      binutils
    ];
  };

  # Enable PodMan
  #virtualisation.podman.enable = true;
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
    dive # look into docker image layers
    podman-tui # status of containers in the terminal
    docker-compose # start group of containers for dev
    podman-compose # start group of containers for dev
  ];

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
  system.stateVersion = "25.05"; # Did you read the comment?

  # Hardware nVidia
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;
  hardware.nvidia.prime = {
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  # Install CUDA
  # allow pip to install wheels
  #unset SOURCE_DATE_EPOCH

  # CUDA setup
  #export CUDA_HOME=${pkgs.cudatoolkit}
  #export CUDA_PATH=${pkgs.cudatoolkit}

  # Library path setup - using system NVIDIA drivers
  #export LD_LIBRARY_PATH=${stdenv.cc.cc.lib}/lib:/run/opengl-driver/lib
  #export LD_LIBRARY_PATH="${pkgs.cudatoolkit}/lib64:${pkgs.cudatoolkit}/lib:$LD_LIBRARY_PATH"
  #export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath buildInputs}:$LD_LIBRARY_PATH"

  # Add CUDA bins to PATH
  #export PATH=${pkgs.cudatoolkit}/bin:$PATH

  # CUDA specific flags
  #export EXTRA_LDFLAGS="-L/lib -L${pkgs.cudatoolkit}/lib64 -L${pkgs.cudatoolkit}/lib"
  #export EXTRA_CCFLAGS="-I/usr/include -I${pkgs.cudatoolkit}/include"


  nix.settings = {
    substituters = [
      "https://cuda-maintainers.cachix.org"
    ];
    trusted-public-keys = [
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    ];
  };
  hardware.nvidia-container-toolkit.enable = true;


  # Home manager configurations
#  home-manager.users.thai =
#    {
#      # MUST be set if using the Home Manager NixOS module
#      home.stateVersion = "25.05-pre";

#      # Waterfox symlink
#      home.file."bin/waterfox" = {
#        source = /home/thai/applications/waterfox/waterfox;
#        executable = true;
#      };
#    };


  # Mount drive
  fileSystems."/home/thai/mnt" =
    { device = "/dev/sda1";
      fsType = "ntfs-3g"; 
      options = [ "rw" "uid=1000"];
    };


  # Environment Variables
    environment.sessionVariables = {
    PYENV_ROOT="$HOME/.pyenv";
    # pyenv flags to be able to install Python
    CPPFLAGS="-I${pkgs.zlib.dev}/include -I${pkgs.libffi.dev}/include -I${pkgs.readline.dev}/include -I${pkgs.bzip2.dev}/include -I${pkgs.openssl.dev}/include";
    CXXFLAGS="-I${pkgs.zlib.dev}/include -I${pkgs.libffi.dev}/include -I${pkgs.readline.dev}/include -I${pkgs.bzip2.dev}/include -I${pkgs.openssl.dev}/include";
    CFLAGS="-I${pkgs.openssl.dev}/include";
    LDFLAGS="-L${pkgs.zlib.out}/lib -L${pkgs.libffi.out}/lib -L${pkgs.readline.out}/lib -L${pkgs.bzip2.out}/lib -L${pkgs.openssl.out}/lib";
    CONFIGURE_OPTS="-with-openssl=${pkgs.openssl.dev}";
    PYENV_VIRTUALENV_DISABLE_PROMPT="1";
  };
}

