{ stdenvNoCC, lib, fetchurl, fetchzip }:

let
  fontin = fetchzip {
    url = "http://www.exljbris.com/dl/fontin2_pc.zip";
    sha256 = "sha256-Gl8kvww1xPar0JOQKFnnOHq+9b9obk2Dej7E6p/Wmck=";
    stripRoot = false;
    name = "fontin";
  };

  fontin-sans = fetchzip {
    url = "http://www.exljbris.com/dl/FontinSans_49.zip";
    sha256 = "sha256-8BIMLX2g+zWj2DP2WptzJWkEIVHX5YNQ59R3UV4hudE=";
    stripRoot = false;
    name = "fontin-sans";
  };
in

stdenvNoCC.mkDerivation {
  name = "fontin-1";

  srcs = [ fontin fontin-sans ];
  sourceRoot = ".";

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/{open,true}type/fontin

    cp fontin/*.ttf $out/share/fonts/truetype/fontin
    cp fontin-sans/*.otf $out/share/fonts/opentype/fontin

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://www.exljbris.com/fontin.html";
    description = "A font designed to be used at small sizes.";
    platforms = platforms.all;
  };
}
