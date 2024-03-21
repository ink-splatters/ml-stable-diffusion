with import <nixpkgs> { } ;
mkShell.override { stdenv = swiftPackages.stdenv; }
{

  nativeBuildInputs = with darwin.apple_sdk.frameworks;[

    swift
    swiftpm
    CoreML
    Accelerate
    NaturalLanguage
  ];

  CFLAGS="-mcpu=apple-m1 -O3";
  CXXFLAGS="-mcpu=apple-m1 -O3";

}
