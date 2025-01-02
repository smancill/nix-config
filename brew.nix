{ config, ... }:

{
  homebrew = {
    enable = false;

    brews = [
      # "bash"
      # "bash-completion"
      # "gromgit/fuse/encfs-mac"
      # "git"
      # "git-gui"
      "pandoc"
      "pandoc-crossref"
      # "pyenv"
      # "pyenv-virtualenv"
      # "zsh"
    ];

    casks = [
      "alt-tab"
      "balenaetcher"
      "calibre"
      "chessx"
      "cmake"
      "docker"
      "dropbox"
      # "eclipse-installer"
      "emacs-mac"
      "firefox"
      "flux"
      "free-ruler"
      "google-chrome"
      "handbrake"
      # "hyperswitch"
      # "inkscape"
      "intellij-idea-ce"
      "iterm2"
      "jdownloader"
      "jiggler"
      "jubler"
      "jupyter-notebook-viewer"
      "keepingyouawake"
      # "keycastr"
      # "kid3"
      # "kindle" (deprecated)
      "krita"
      "macfuse"
      "macvim"
      "megasync"
      "mkvtoolnix"
      "mpv"
      # "oversight"
      "paintbrush"
      "pika"
      # "protonvpn"
      "qbittorrent"
      "qlimagesize"
      # "qview"
      "rar"
      "sigil"
      # "skype"
      "smcfancontrol"
      # "sony-ps-remote-play"
      # "suspicious-package"
      "syncthing"
      # "temurin21"
      "the-unarchiver"
      "transmission"
      "tuxera-ntfs"
      # "ukelele"
      # "universal-media-server"
      "virtualbox"
      # "visual-studio-code"
      # "vlc"
      # "wezterm"
      "xquartz"
      "yacreader"
      "zoom"
    ];

    taps = [
      # "gromgit/fuse"
      "railwaycat/emacsmacport"
    ];
  };
}
