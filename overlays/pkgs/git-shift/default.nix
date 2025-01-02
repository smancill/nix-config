{ stdenv
, lib
, fetchFromGitHub
, makeWrapper
, git
, perlPackages
}:

stdenv.mkDerivation {
  pname = "git-shift";
  version = "2020-06";

  src = fetchFromGitHub {
    owner = "gitbits";
    repo = "git-shift";
    rev = "7b65b058f9568ec68785ee3d267be9299d8d17c2";
    sha256 = "sha256-HjT3TVDfzoRrioQcr7PiP2WqDxBpHvkJdSfGRYtZ4/k=";
  };

  nativeBuildInputs = [ makeWrapper ];

  # attribute 'TimePiece' missin
  #   --set PERL5LIB ${perlPackages.makePerlPath [ perlPackages.TimePiece ]}
  installPhase = ''
    runHook preInstall

    install -Dm755 git-shift $out/bin/git-shift

    wrapProgram $out/bin/git-shift \
        --prefix PATH ':' ${lib.makeBinPath [ perlPackages.perl git ]} \

    runHook postInstall
  '';

  meta = with lib; {
    description = "Shift timestamps of commits after the fact";
    homepage = "https://github.com/gitbits/git-shift";
    platforms = platforms.unix;
  };
}
