{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "ran";
  version = "0.1.6";

  src = fetchFromGitHub {
    owner = "m3ng9i";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-iMvUvzr/jaTNdgHQFuoJNJnnkx2XHIUUlrPWyTlreEw=";
  };
  vendorHash = "sha256-ObroruWWNilHIclqNvbEaa7vwk+1zMzDKbjlVs7Fito=";

  # TODO: buildFlagsArray -> ldflags
  ldflags = [
    "-X main._version_=${version}"
  ];

  preBuild = ''
    substituteInPlace ran.go \
        --replace 'Version: %s, Branch: %s, Build: %s, Build time: %s' '${pname} %s' \
        --replace '_version_, _branch_, _commitId_, _buildTime_' '_version_'
  '';

  postInstall = ''
    mv $out/bin/ran $out/bin/ran-http-server
  '';

  meta = with lib; {
    description = "Simple static web server written in Go";
    homepage = "https://github.com/m3ng9i/ran";
    license = licenses.mit;
    platforms = platforms.unix;
  };
}
