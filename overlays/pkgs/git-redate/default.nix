{ stdenv
, lib
, fetchFromGitHub
, makeWrapper
, git
, coreutils
, gawk
}:

stdenv.mkDerivation {
  pname = "git-redate";
  version = "1.0.2-21";

  src = fetchFromGitHub {
    owner = "PotatoLabs";
    repo = "git-redate";
    rev = "1.0.2-21-g843b964";
    sha256 = "sha256-RKt6sLs+TYcCpZ3mmXhfje3vcU8/NkdhS43gfhGWhQg=";
  };

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    substituteInPlace git-redate --replace \
        'SETTINGS_FILE="~/.redate-settings";' \
        'SETTINGS_FILE=''${XDG_CONFIG_HOME:-''$HOME/.config}/git-redate/settings;';

    install -Dm755 git-redate $out/bin/git-redate

    wrapProgram $out/bin/git-redate \
        --prefix PATH ':' ${lib.makeBinPath [ git coreutils gawk ]}

    runHook postInstall
  '';

  meta = with lib; {
    description = "Change the dates of several Git commits with a single command.";
    homepage = "https://github.com/PotatoLabs/git-redate";
    license = licenses.unfree;
    platforms = platforms.unix;
  };
}
