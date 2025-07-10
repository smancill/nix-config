{ config, lib, pkgs, inputs, username, hostname, ... }:

{
  imports = [
    ./brew.nix
  ];

  environment = {
    profiles = lib.mkOrder 700 [ "\$HOME/.local/state/nix/profile" ];

    shells = with pkgs; [
      bashInteractive
      zsh
    ];

    systemPackages = with pkgs; [
      (pkgs.runCommand "zsh-fixed-man" { } ''
        mkdir -p $out/share/man/man1
        cd $out/share/man/man1
        for i in ${pkgs.zsh.man}/share/man/man1/*.gz; do
            n=$(basename $i)
            zcat $i > ''${n%.gz}
        done
      '')
    ];

    systemPath = lib.mkIf pkgs.stdenv.hostPlatform.isAarch64
      (lib.mkOrder 1100 [ "/opt/homebrew/bin" ]);

    variables = {
      EDITOR = "vim";
      VISUAL = "vim";
    };
  };

  fonts.packages = [
    pkgs.fontin
    pkgs.vistafonts
  ];

  programs.zsh = {
    enable = true;
    enableBashCompletion = false;
    enableCompletion = false;
    promptInit = "";
  };

  nix = {
    channel.enable = false;

    extraOptions = ''
      experimental-features = nix-command flakes
      keep-derivations = true
      keep-outputs = true
      use-xdg-base-directories = true
    '' + lib.optionalString pkgs.stdenv.hostPlatform.isAarch64 ''
      extra-platforms = x86_64-darwin aarch64-darwin
    '';

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };

    registry = {
      system.flake = inputs.self;
      nixpkgs.flake = inputs.nixpkgs;
      unstable.flake = inputs.nixpkgs-unstable;
    };

    settings = {
      trusted-users = [ username ];
    };
  };

  networking = {
    computerName = "${hostname}";
    hostName = "${hostname}";
    knownNetworkServices = [
      "Wi-Fi"
    ];
    dns = [
      # https://1.1.1.1/dns/
      "1.1.1.1"
      "1.0.0.1"
      "2606:4700:4700::1111"
      "2606:4700:4700::1001"
    ];
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  system.defaults = {
    NSGlobalDomain = {
      AppleEnableSwipeNavigateWithScrolls = true;
      AppleFontSmoothing = 0;
      AppleICUForce24HourTime = true;
      AppleKeyboardUIMode = 3;
      AppleMeasurementUnits = "Centimeters";
      AppleMetricUnits = 1;
      AppleShowAllExtensions = true;
      AppleShowScrollBars = "WhenScrolling";
      AppleTemperatureUnit = "Celsius";
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSAutomaticWindowAnimationsEnabled = false;
      NSDocumentSaveNewDocumentsToCloud = false;
      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;
      NSScrollAnimationEnabled = false;  # smooth scrolling
      NSTableViewDefaultSizeMode = 1;
      NSTextShowsControlCharacters = false;
      NSUseAnimatedFocusRing = false;
      NSWindowResizeTime = 0.001;
      PMPrintingExpandedStateForPrint = true;
      PMPrintingExpandedStateForPrint2 = true;
      "com.apple.keyboard.fnState" = true;
      "com.apple.mouse.tapBehavior" = 1;
      "com.apple.sound.beep.feedback" = 0;
      "com.apple.sound.beep.volume" = 0.0;
      "com.apple.swipescrolldirection" = false;
    };

    alf = {
      allowdownloadsignedenabled = 1;
      allowsignedenabled = 1;
      globalstate = 1;
    };

    controlcenter = {
      Bluetooth = true;
      FocusModes = false;
      NowPlaying = false;
      Sound = true;
    };

    dock = {
      autohide = false;
      expose-animation-duration = 0.1;
      expose-group-apps = false;
      launchanim = false;
      mineffect = "scale";
      minimize-to-application = true;
      mouse-over-hilite-stack = true;
      mru-spaces = false;
      orientation = "bottom";
      show-process-indicators = true;
      show-recents = false;
      showhidden = true;
      tilesize = if pkgs.stdenv.hostPlatform.isAarch64 then 52 else 46;
    };

    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = false;
      FXDefaultSearchScope = "SCcf";
      FXPreferredViewStyle = "Nlsv";
      ShowPathbar = true;
      ShowStatusBar = false;
      _FXShowPosixPathInTitle = true;
      _FXSortFoldersFirst = true;
    };

    loginwindow = {
      GuestEnabled = false;
    };

    menuExtraClock = {
      Show24Hour = true;
      ShowDate = 1;
      ShowDayOfMonth = true;
      ShowDayOfWeek = true;
      ShowSeconds = false;
    };

    screencapture = {
      disable-shadow = true;
      include-date = false;
      show-thumbnail = true;
      type = "png";
      location = "~/Downloads";
    };

    trackpad = {
      Clicking = true;
      Dragging = true;
      TrackpadRightClick = true;
    };

    universalaccess = {
      reduceMotion = true;
      reduceTransparency = true;
    };

    CustomUserPreferences = {
      kCFPreferencesAnyApplication = {
        TSMLanguageIndicatorEnabled = 0;
      };
    };
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  system.primaryUser = "${username}";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  time.timeZone = "America/Santiago";

  users = {
    users.${username} = {
      shell = pkgs.zsh;
      home = "/Users/${username}";
    };
  };
}
