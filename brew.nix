{ pkgs, lib, ... }:

{
  homebrew = {
    enable = true;

    brews = [ ];

    casks = [
      "alt-tab"
      "balenaetcher"
      "chessx"
      "cmake"
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
      "sigil"
      "stolendata-mpv"
      "syncthing"
      "the-unarchiver"
      "transmission"
      "xquartz"
      "yacreader"
    ] ++ lib.optionals pkgs.stdenv.hostPlatform.isx86_64 [
      "tuxera-ntfs"
    ] ++ lib.optionals pkgs.stdenv.hostPlatform.isAarch64 [
      "calibre"
      "docker"
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
