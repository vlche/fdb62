{ stdenv, gccStdenv, llvmPackages
, lib, fetchurl, fetchpatch, fetchFromGitHub
, cmake, ninja, which, findutils, m4, gawk
, python, python3, openjdk, mono, openssl, boost
}@args:

let
  cmakeBuild = import ./cmake.nix (args // {
    gccStdenv    = gccStdenv;
    llvmPackages = llvmPackages;
  });

  python3-six-patch = fetchpatch {
    name   = "update-python-six.patch";
    url    = "https://github.com/apple/foundationdb/commit/4bd9efc4fc74917bc04b07a84eb065070ea7edb2.patch";
    sha256 = "030679lmc86f1wzqqyvxnwjyfrhh54pdql20ab3iifqpp9i5mi85";
  };

  python3-print-patch = fetchpatch {
    name   = "import-for-python-print.patch";
    url    = "https://github.com/apple/foundationdb/commit/ded17c6cd667f39699cf663c0e87fe01e996c153.patch";
    sha256 = "11y434w68cpk7shs2r22hyrpcrqi8vx02cw7v5x79qxvnmdxv2an";
  };

  glibc230-fix = fetchpatch {
    url = "https://github.com/Ma27/foundationdb/commit/e133cb974b9a9e4e1dc2d4ac15881d31225c0197.patch";
    sha256 = "1v9q2fyc73msigcykjnbmfig45zcrkrzcg87b0r6mxpnby8iryl1";
  };

in with builtins; {

  # 6.2 and later versions should always use CMake
  # ------------------------------------------------------

  foundationdb62 = cmakeBuild {
    version = "6.2.25";
    branch  = "release-6.2";
# nix-prefetch-url --unpack --type sha256 https://github.com/apple/foundationdb/archive/6.2.25.tar.gz
    sha256  = "01p8q0kpcnki65hlk5sav2isjlskqrwq5281maghhk9fzsc1cx26";

    patches = [
      #./patches/clang-libcxx.patch
      ./patches/CMakeLists.patch
      ./patches/suppress-clang-warnings.patch
      glibc230-fix
    ];
  };

}
