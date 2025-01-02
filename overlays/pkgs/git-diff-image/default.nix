{ stdenv, lib, fetchFromGitHub, makeWrapper
, git, imagemagick, exiftool, gnugrep, diffutils, colordiff
}:
stdenv.mkDerivation {
  pname = "git-diff-image";
  version = "2022-11";

  src = fetchFromGitHub {
    owner = "ewanmellor";
    repo = "git-diff-image";
    rev = "f2663bc34991f6c2793dc20a1f2889ad9577a702";
    sha256 = "sha256-0+iLE1v5aZhwrHGd9ifJvuMLq3IVhI2AM4HtoAke+rE=";
  };

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    install -Dm755 git_diff_image $out/libexec/git-diff-image
    install -Dm755 diff-image $out/bin/diff-image

    sed -i -e "s|^thisdir=.*$|thisdir=$out/bin|" $out/libexec/git-diff-image

    sed -i -e "s|diff -u|colordiff -u|" \
           -e "/diff_clean_names /a echo" \
           $out/bin/diff-image

    wrapProgram $out/libexec/git-diff-image \
        --prefix PATH ':' ${lib.makeBinPath [ imagemagick diffutils ]}

    wrapProgram $out/bin/diff-image \
        --prefix PATH ':' ${lib.makeBinPath [ imagemagick exiftool gnugrep diffutils colordiff ]}

    runHook postInstall
  '';

  meta = with lib; {
    description = "An extension to 'git diff' that provides support for diffing images.";
    homepage = "https://github.com/ewanmellor/git-diff-image";
    platforms = platforms.unix;
  };
}
