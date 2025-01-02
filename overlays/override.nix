final: prev:

let
  overridePriority = pkg: priority: pkg.overrideAttrs (oldAttrs: {
      meta = oldAttrs.meta // { priority = priority; };
    }
  );

  overrideOutputs = pkg: outputs: pkg.overrideAttrs (oldAttrs: {
      meta = oldAttrs.meta // { outputsToInstall = outputs; };
    }
  );

  gnu = let
    gnuWrapper = orig: binaries:
      final.runCommand "${orig.pname}-wrapped-${orig.version}" { } ''
        mkdir -p $out/bin
        man=${if orig ? man then orig.man else orig}
        for i in ${binaries}; do
            ln -s ${orig}/bin/$i $out/bin/g$i
            if [ -f $man/share/man/man1/$i.1.gz ]; then
                mkdir -p $out/share/man/man1
                ln -s $man/share/man/man1/$i.1.gz $out/share/man/man1/g$i.1.gz
            elif [ -f $man/share/man/man5/$i.5.gz ]; then
                mkdir -p $out/share/man/man5
                ln -s $man/share/man/man5/$i.5.gz $out/share/man/man5/g$i.5.gz
            fi
        done
      '';
    in {
      # TODO: fix
      awk = final.gawkInteractive;

      coreutils = let full = final.coreutils-full; pref = final.coreutils-prefixed; in
        final.runCommand "coreutils-wrapped-${pref.version}" { } ''
          mkdir -p $out/bin $out/share/man/man1
          for i in ${pref}/bin/*; do
              ln -s $i $out/bin/$(basename $i)
          done
          for i in ${full}/share/man/man1/*; do
              ln -s $i $out/share/man/man1/g$(basename $i)
          done
          rm $out/share/man/man1/gcoreutils.1.gz
        '';

      diffutils = gnuWrapper final.diffutils "cmp diff diff3 sdiff";

      findutils = gnuWrapper final.findutils "find xargs";

      grep = gnuWrapper final.gnugrep "grep egrep fgrep";

      make = gnuWrapper final.gnumake "make";

      man-db = gnuWrapper final.man-db "apropos man manpath whatis";

      sed = gnuWrapper final.gnused "sed";

      tar = gnuWrapper final.gnutar "tar";

      # gnu-indent
      # gnu-time
      # gnu-units
      # gnu-which
      # libtool
    };

  latexPackages = {
    texlive = final.texlive.combine {
      # https://github.com/NixOS/nixpkgs/blob/master/pkgs/tools/typesetting/tex/texlive/pkgs.nix
      # https://ctan.dcc.uchile.cl/systems/texlive/tlnet/tlpkg/texlive.tlpdb
      inherit (final.texlive)
        ## scheme-basic
        collection-basic
        collection-latex

        ## other collections
        collection-latexrecommended
        collection-metapost
        collection-xetex

        ## collection-binextra
        chktex
        latexmk
        pdfjam
        pdfcrop

        ## collection-fontsrecommended
        courier
        eurosym
        helvetic
        lm
        lm-math
        times
        tipa

        ## collection-langspanish
        babel-spanish
        hyphen-english
        hyphen-spanish

        ## collection-latexextra
        upquote

        ## org-mode
        capt-of
        dvipng
        dvisvgm
        # framed
        # fvextra
        # minted
        ulem
        wrapfig

        ## pandoc
        # biblatex
        physics
        siunitx
        framed
        # logreq
        # titlesec
        # preprint
        ;
    };
  };
in
{
  fzf = let orig = prev.fzf; in
    final.runCommand "${orig.pname}-wrapped-${orig.version}" { } ''
      # Link binaries
      mkdir -p $out/bin $out/share/man/man1
      for i in fzf fzf-tmux; do
          ln -s ${orig}/bin/$i $out/bin
          ln -s ${orig.man}/share/man/man1/$i.1.gz $out/share/man/man1
      done

      # Link Vim plugin
      mkdir -p $out/share/vim-plugins
      ln -s ${orig}/share/vim-plugins/fzf $out/share/vim-plugins

      # Install shell scripts (patch missed binaries)
      mkdir -p $out/share/fzf
      cp ${orig}/share/fzf/*.{zsh,bash} $out/share/fzf
      sed -i -E \
          -e "s@command find @${final.findutils}/bin/find @" \
          -e "s@(command grep|grep( -[[:alpha:]]))@${final.gnugrep}/bin/grep\2@g" \
          -e "s@sed ([[:digit:]'-])@${final.gnused}/bin/sed \1@g" \
          -e "s@awk (['-])@${final.gawk}/bin/awk \1@g" \
          $out/share/fzf/*

      # Install shell integration
      # Taken from the install script
      for shell in bash zsh; do
          cat <<SCRIPT > $out/share/fzf/fzf.$shell
      # Auto-completion
      # ---------------
      [[ \$- == *i* ]] && source "$out/share/fzf/completion.$shell"

      # Key bindings
      # ------------
      source "$out/share/fzf/key-bindings.$shell"
      SCRIPT
      done
    '';

  gnu-wrapped = gnu;

  gradle-completion = prev.gradle-completion.overrideAttrs (finalAttrs: {
    postPatch = ''
      substituteInPlace _gradle \
          --replace 'cache_dir="$HOME/.gradle/completion"' 'cache_dir="''${GRADLE_USER_HOME:-HOME/.gradle}/completion"'
      '';
  });

  texlive-minimal = overridePriority latexPackages.texlive 4;

  mr = prev.mr.overrideAttrs (finalAttrs: {
    patches = [
      ./patches/mr/use-xdg.patch
    ];
  });

  ranger = prev.ranger.overrideAttrs (finalAttrs: {
    patches = [
      ./patches/ranger/fix-mimetypes.patch
    ];
  });
}
