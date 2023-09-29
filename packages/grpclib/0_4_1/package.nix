{ python3Packages
, fetchFromGitHub
, lib
}:
let
  pname = "grpclib";
  version = "0.4.1";
in
python3Packages.buildPythonPackage {
  inherit pname version;
  disabled = python3Packages.pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "vmagamedov";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-VZHRmbTlUzGOhc5TjkUKQiRcm9sH+wDwGdq11NjvU68=";
  };

  propagatedBuildInputs = with python3Packages; [
    h2
    multidict
  ];

  nativeCheckInputs = with python3Packages; [
    pytestCheckHook
    pytest-asyncio
    async-timeout
    faker
    googleapis-common-protos
    certifi
  ];

  pythonImportsCheck = [ "grpclib" ];

  meta = with lib; {
    description = "Pure-Python gRPC implementation for asyncio";
    homepage = "https://github.com/vmagamedov/grpclib";
    license = licenses.bsd3;
    maintainers = with maintainers; [ nikstur ];
  };
}
