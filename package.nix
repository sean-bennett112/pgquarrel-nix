{ lib, cmake, postgresql_14, stdenv, src }:
stdenv.mkDerivation rec {
  name = "pgquarrel";

  inherit src;

  buildInputs = [ cmake postgresql_14 ];

  # This patch sets the correct path to lookup the statically linked libs.
  patchPhase = ''
    sed -i '/set(PostgreSQL_LIBRARY_DIRS "''${pgpath}")/a set(pgpath "${postgresql_14}/lib")' CMakeLists.txt
  '';

  meta = {
    description = "Tool to compare PostgreSQL database schemas (DDL)";
    homepage = "https://github.com/eulerto/pgquarrel";
    license = lib.licenses.bsd3;
    platforms = [ "x86_64-linux" "aarch64-linux" ];
  };
}
