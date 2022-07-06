{ lib
, stdenv
, fetchFromGitLab
, flac
}:

stdenv.mkDerivation rec {
  pname = "shntool";
  version = "3.0.10";

  src = fetchFromGitLab {
    domain = "salsa.debian.org";
    owner = "debian";
    repo = "shntool";
    rev = "18a31ab331aadb706978fd2e67418c0e740385ac";
    sha256 = "1g28qvl0vvxy8sdlvq665iz1s6j3pmkxlfkrdj4sfzsb8khixyj5";
  };

  buildInputs = [ flac ];

  patches = [
    "${src}/debian/patches/950803.patch"
    "${src}/debian/patches/large-size.patch"
    "${src}/debian/patches/large-times.patch"
    "${src}/debian/patches/no-cdquality-check.patch"
  ];

  meta = {
    description = "Multi-purpose WAVE data processing and reporting utility";
    homepage = "http://www.etree.org/shnutils/shntool/";
    license = lib.licenses.gpl2Plus;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ jcumming ];
  };
}
