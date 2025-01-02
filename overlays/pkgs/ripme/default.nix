{ stdenv
, lib
, fetchurl
, makeWrapper
, jre
}:

stdenv.mkDerivation rec {
  pname = "ripme";
  version = "1.7.95";

  src = fetchurl {
    url = "https://github.com/RipMeApp/ripme/releases/download/${version}/${pname}.jar";
    sha256 = "sha256-AIIB5Ab0AbJySCd6QYjyYgO7naAXCHLekAEl+KbItVg=";
  };

  nativeBuildInputs = [ makeWrapper ];

  buildInputs = [ jre ];

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    install -Dm644 ${src} $out/share/${pname}.jar

    makeWrapper ${jre}/bin/java $out/bin/${pname} \
        --argv0 ${pname} \
        --add-flags "-jar $out/share/${pname}.jar"

    runHook postInstall
  '';

  meta = with lib; {
    description = "Downloads albums in bulk";
    homepage = "https://github.com/RipMeApp/ripme";
    license = licenses.mit;
    platforms = platforms.unix;
  };
}
