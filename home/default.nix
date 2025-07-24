{ lib, pkgs, unstable, ... }:

{
  home.stateVersion = "25.05";

  home.preferXdgDirectories = true;

  home.packages = [
    pkgs.age
    pkgs.ansible
    pkgs.ant
    pkgs.ascii
    pkgs.asciinema
    pkgs.aspell
    pkgs.aspellDicts.en
    pkgs.aspellDicts.es
    pkgs.atool
    pkgs.bmon
    pkgs.bzip2
    pkgs.ccache
    pkgs.checkbashisms
    pkgs.clang-analyzer
    pkgs.clang-tools
    pkgs.cloc
    pkgs.colordiff
    pkgs.cookiecutter
    pkgs.cppcheck
    pkgs.cscope
    pkgs.cuetools
    pkgs.diff-pdf
    pkgs.ditaa
    pkgs.doitlive
    pkgs.dos2unix
    pkgs.doxygen
    pkgs.fd
    pkgs.ffmpeg-full
    pkgs.flac
    pkgs.fzf
    pkgs.gcal
    pkgs.gh
    pkgs.ghostscript
    pkgs.git-extras
    pkgs.git-when-merged
    pkgs.gitFull
    pkgs.gnu-wrapped.awk
    pkgs.gnu-wrapped.coreutils
    pkgs.gnu-wrapped.diffutils
    pkgs.gnu-wrapped.findutils
    pkgs.gnu-wrapped.grep
    pkgs.gnu-wrapped.make
    pkgs.gnu-wrapped.man-db
    pkgs.gnu-wrapped.sed
    pkgs.gnu-wrapped.tar
    pkgs.gnupg
    pkgs.gnuplot
    pkgs.gopass
    pkgs.gradle
    pkgs.gradle-completion
    pkgs.graphviz
    pkgs.gzip
    pkgs.hledger
    pkgs.htop
    pkgs.httpie
    pkgs.hyperfine
    pkgs.imagemagick
    pkgs.iperf
    pkgs.jq
    pkgs.ledger
    pkgs.less
    pkgs.lftp
    pkgs.libfaketime
    pkgs.libqalculate
    pkgs.lzip
    pkgs.maven
    pkgs.mediainfo
    pkgs.meson
    pkgs.mp3splt
    pkgs.mpd
    pkgs.mr
    pkgs.mypy
    pkgs.ncdu
    pkgs.ncmpcpp
    pkgs.ninja
    pkgs.niv
    pkgs.nix-tree
    pkgs.nix-update
    pkgs.nix-zsh-completions
    pkgs.nixfmt-rfc-style
    pkgs.nmap
    pkgs.openssh
    pkgs.p7zip
    pkgs.pandoc
    pkgs.parallel
    pkgs.patchutils
    pkgs.pdftk
    pkgs.perlPackages.ImageExifTool
    pkgs.pkgdiff
    pkgs.plantuml
    pkgs.pngquant
    pkgs.pstree
    pkgs.pv
    pkgs.python313
    pkgs.python3Packages.ipython
    pkgs.python3Packages.pipx
    pkgs.qpdf
    pkgs.rar
    pkgs.rename
    pkgs.ripgrep
    pkgs.rsync
    pkgs.sc-im
    pkgs.sd
    pkgs.shellcheck
    pkgs.shntool
    pkgs.srm
    pkgs.stgit
    pkgs.stockfish
    pkgs.stow
    pkgs.texlive-minimal
    pkgs.tig
    pkgs.tmate
    pkgs.tmux
    pkgs.transmission_4
    pkgs.tree
    pkgs.universal-ctags
    pkgs.unzip
    pkgs.w3m
    pkgs.wdiff
    pkgs.wget
    pkgs.wgetpaste
    pkgs.xz
    pkgs.yt-dlp
    pkgs.zathura
    pkgs.zip
    pkgs.zsh-completions
    pkgs.zstd
  ] ++ [
    unstable.neovim
    unstable.nixpkgs-review
    unstable.ranger
    unstable.ruff
    unstable.vim
  ] ++ [
    pkgs.cdargs
    pkgs.git-diff-image
    pkgs.git-shift
    pkgs.ran
    pkgs.ripme
  ];

  # Direnv
  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
      package = unstable.nix-direnv;
    };
  };

  # Git
  home.file.".local/bin/diff-highlight" = {
    source = "${pkgs.git}/share/git/contrib/diff-highlight/diff-highlight";
  };

  # GnuPG
  home.activation = {
    # Need to kill gpg-agent from previous generation
    kill-gpg-agent = lib.hm.dag.entryAfter ["writeBoundary"] ''
      if /usr/bin/pgrep -x gpg-agent; then
          /usr/bin/pkill -x gpg-agent
      fi
    '';
  };

  # Shell
  home.file.".hushlogin" = {
    text = "";
  };
}
