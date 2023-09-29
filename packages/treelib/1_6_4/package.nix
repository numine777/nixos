{ lib
, fetchPypi
, python3Packages
}:

python3Packages.buildPythonApplication rec {
  pname = "treelib";
  version = "1.6.4";
  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-Gi6Dj2uZ4mkLw9mS1aHwTNtK9lZL12iIg8I9FyV7uyo=";
  };
  propagatedBuildInputs = with python3Packages; [ six ];

}
