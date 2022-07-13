{ lib, stdenv, fetchurl, cmake, perl }:

stdenv.mkDerivation rec {
  pname = "microsoft-pict";
  version = "v3.7.4";

  src = fetchurl {
    url = "https://github.com/microsoft/pict/archive/refs/tags/${version}.tar.gz";
    sha256 = "42af3ac7948d5dfed66525c4b6a58464dfd8f78a370b1fc03a8d35be2179928f";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [ perl ];

  configurePhase = ''
    cmake -DCMAKE_BUILD_TYPE=Release -S . -B build
  '';

  buildPhase = ''
    cmake --build build
    pushd build && ctest -v && popd
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp build/cli/pict $out/bin
  '';

  meta = with lib; {
    homepage = "https://github.com/microsoft/pict";
    description = "Pairwise Independent Combinatorial Tool";
    platforms = platforms.linux;
    license = licenses.mit;
  };
}
