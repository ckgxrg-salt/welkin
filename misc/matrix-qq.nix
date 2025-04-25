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
    owner = "ckgxrg-salt";
    repo = "matrix-qq";
    rev = "3bf8423e3e47d79610d2794d5c25dd219fbd06d0";
    hash = "sha256-cLcwafAPTAPM3eFvQ3yBqXHTKj+zGiINaUVl4Z+aZPc=";
  };

  tags = "goolm";

  vendorHash = "sha256-ygin1CNbCN8DWfu/5046HA0uDTCJoPlwzsDQ4p0AAKg=";

  meta = {
    homepage = "https://github.com/duo/matrix-qq";
    description = "A Matrix-QQ puppeting bridge";
    license = lib.licenses.agpl3Plus;
  };
}
