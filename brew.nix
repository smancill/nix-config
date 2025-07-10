{ pkgs, lib, ... }:

{
  homebrew = {
    enable = true;

    brews = [ ];

    casks = [
      "alt-tab"
      "balenaetcher"
      "chessx"
      "cmake-app"
      "dropbox"
      "emacs-mac"
      "firefox"
      "google-chrome"
      "handbrake-app"
      "intellij-idea-ce"
      "iterm2"
      "jdownloader"
      "jupyter-notebook-viewer"
      "keepingyouawake"
      "macvim-app"
      "megasync"
      "mkvtoolnix-app"
      "pika"
      "sigil"
      "stolendata-mpv"
      "syncthing-app"
      "the-unarchiver"
      "transmission"
      "xquartz"
      "yacreader"
    ] ++ lib.optionals pkgs.stdenv.hostPlatform.isx86_64 [
      "tuxera-ntfs"
    ] ++ lib.optionals pkgs.stdenv.hostPlatform.isAarch64 [
      "calibre"
      "docker-desktop"
      "ghostty"
      "podman-desktop"
      "protonvpn"
    ] ++ [
      "omnissa-horizon-client"
      "zoom"
    ];

    global = {
      autoUpdate = false;
    };

    taps = [
      "railwaycat/emacsmacport"
    ];
  };
}
