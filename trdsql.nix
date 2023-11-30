{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "trdsql";
  version = "0.10.0";

  src = fetchFromGitHub {
    owner = "noborus";
    repo = "trdsql";
    rev = "v${version}";
    sha256 = "05q1g8836k372pinbqs2zlpszrbczxinha4axkns0m0iq6zayvr9";
  };

  # vendorHash = lib.fakeSha256;
  vendorHash = "sha256-uJAf0gw/QQhmdadOPJdxAbf8BVfr2htllLAXpRIYtwE=";

  meta = with lib; {
    description = "CLI tool that can execute SQL queries on CSV, LTSV, JSON and TBLN.";
    homepage = "https://noborus.github.io/trdsql/";
    license = licenses.mit;
  };

  subPackages = [
    "cmd/trdsql"
  ];
}
