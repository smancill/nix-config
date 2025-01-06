{ pkgs, lib, ... }:

{
  homebrew = {
    enable = true;

    brews = [ ];

    casks = [
      "alt-tab"
      "balenaetcher"
      "calibre"
      "chessx"
      "cmake"
      "docker"
      "dropbox"
      "emacs-mac"
      "firefox"
      "google-chrome"
      "handbrake"
      "intellij-idea-ce"
      "iterm2"
      "jdownloader"
      "jupyter-notebook-viewer"
      "keepingyouawake"
      "macvim"
      "megasync"
      "mkvtoolnix"
      "pika"
      "qbittorrent"
      "sigil"
      "stolendata-mpv"
      "syncthing"
      "the-unarchiver"
      "transmission"
      "xquartz"
      "yacreader"
      "zoom"
    ] ++ lib.optionals pkgs.stdenv.hostPlatform.isx86_64 [
      "tuxera-ntfs"
    ] ++ lib.optionals pkgs.stdenv.hostPlatform.isAarch64 [
      "ghostty"
      "podman-desktop"
      "protonvpn"
    ] ++ [
      "omnissa-horizon-client" 
    ];

    global = {
      autoUpdate = false;
    };

    taps = [
      "railwaycat/emacsmacport"
    ];
  };
}
