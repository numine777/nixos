{ lib
, fetchPypi
, python3Packages
, protobuf
, treelib
, idb_grpclib
}:

python3Packages.buildPythonApplication rec {
  pname = "fb-idb";
  version = "1.1.7";
  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-GDAkAmaxGiT9dpUiDTqKNVC841HE0Bn65Smtu1CNeK4=";
  };
  FB_IDB_VERSION = version;
  buildInputs = with python3Packages; [ grpcio-tools idb_grpclib ];
  propagatedBuildInputs = with python3Packages; [ treelib protobuf aiofiles grpclib ];
}
