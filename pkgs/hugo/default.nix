{ stdenvNoCC, fetchurl}:

let
  pname = "hugo_extended";
  version = "0.140.1";
  src =
    if stdenvNoCC.hostPlatform.isLinux && stdenvNoCC.hostPlatform.system == "x86_64-linux" then
      fetchurl {
        url = "https://github.com/gohugoio/hugo/releases/download/v${version}/hugo_extended_${version}_linux-amd64.tar.gz";
        sha256 = "sha256-fu9u6RQ63Sgn4p6sNw7k45+dLt3cg1Ocfp8/6tfg9y8=";
      }
    else if stdenvNoCC.hostPlatform.isLinux && stdenvNoCC.hostPlatform.system == "aarch64-linux" then
      fetchurl {
        url = "https://github.com/gohugoio/hugo/releases/download/v${version}/hugo_extended_${version}_linux-arm64.tar.gz";
        sha256 = "";
      }
    else if stdenvNoCC.hostPlatform.isDarwin then
      fetchurl {
        url = "https://github.com/gohugoio/hugo/releases/download/v${version}/hugo_extended_${version}_darwin-universal.tar.gz";
        sha256 = "sha256-dLfD+QCsywRipJ64XkykhcnFbrftKI4HXRE3vWV51f0=";
      }
    else
      throw "Unsupported system";
in
stdenvNoCC.mkDerivation rec {
  inherit pname version src;
  buildInputs = [
  ];
  unpackPhase = ''
    tar -xzf $src
  '';
  installPhase = ''
    mkdir -p $out/bin
    install -Dm755 hugo $out/bin/hugo
  '';
}
