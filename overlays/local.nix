final: prev:

{
  cdargs = final.callPackage ./pkgs/cdargs {};

  fontin = final.callPackage ./pkgs/fontin {};

  git-diff-image = final.callPackage ./pkgs/git-diff-image {};

  git-redate = final.callPackage ./pkgs/git-redate {};

  git-shift = final.callPackage ./pkgs/git-shift {};

  ran = final.callPackage ./pkgs/ran  {};

  ripme = final.callPackage ./pkgs/ripme {};
}
