{ lib, stdenv, fetchzip }:

stdenv.mkDerivation rec {
  pname = "cica";
  version = "5.0.3";

  src = fetchzip {
    url = "https://github.com/miiton/Cica/releases/download/v${version}/Cica_v${version}.zip";
    sha256 = "0vshn2cd70mnbavsw9cbagcasa95wiv9qdj4wkzxn7gxygqvrlfb";
  };

  meta = with lib; {
    license = licenses.ofl;
  };
  # NOTE: 切り替え出来るようにしたいが一旦雑にコメントアウト
  # src = fetchzip {
  #   url = "https://github.com/miiton/Cica/releases/download/v${version}/Cica_v${version}_without_emoji.zip";
  #   sha256 = "1gvx91yf68f870gxpvy2v0nfi7m6mwn7lmrgcdw3g3g9qg49ak71";
  # };
  installPhase = ''
    find $srcs -name '*.ttf' | xargs install -m644 --target $out/share/fonts/truetype/Cica -D
  '';
}

