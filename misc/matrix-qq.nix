{
  buildGoModule,
  fetchFromGitHub,
  lib,
}:

buildGoModule {
  pname = "matrix-qq";
  version = "0.1.11";

  subPackages = [ "cmd/matrix-qq" ];

  src = fetchFromGitHub {
    owner = "duo";
    repo = "matrix-qq";
    rev = "69ec39e42a76406e105efad1d48fb21a09b2661c";
    hash = "sha256-bfskjmlWd6DSc04rZU3/D/zOUflE8Ymgk+ZoLlyzPRs=";
  };

  tags = "goolm";

  vendorHash = "sha256-V4t6G9fh+lKeN49cD/Iy24KQNQXUunNSn9eS2mZRXx0=";

  meta = {
    homepage = "https://github.com/duo/matrix-qq";
    description = "A Matrix-QQ puppeting bridge";
    license = lib.licenses.agpl3Plus;
  };
}
