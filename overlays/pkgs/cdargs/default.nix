{ stdenv, lib, fetchFromGitHub, meson, ninja, pkg-config, ncurses }:

stdenv.mkDerivation rec {
  pname = "cdargs";
  version = "2.1";

  src = fetchFromGitHub {
    owner = "cbxbiker61";
    repo = pname;
    rev = "${version}";
    sha256 = "sha256-NxjObIowlsq2H/FZYJKfsDfrNFJkQcw8KVgd4NAsmjQ=";
  };

  patches = [
    ./01-fix-style.patch
    ./02-use-xdg-paths.patch
    ./03-fix-zsh-completion.patch
  ];

  nativeBuildInputs = [ meson ninja pkg-config ];

  buildInputs = [ ncurses ];

  postInstall = ''
    install -D ../contrib/cdargs-bash.sh $out/share/cdargs/cdargs-bash.sh
  '';

  outputs = [ "out" "man" ];

  meta = with lib; {
    description = "Directory bookmarking system and enhanced cd utilities";
    homepage = "https://github.com/cbxbiker61/cdargs";
    license = licenses.gpl2Plus;
    platforms = platforms.unix;
  };
}
