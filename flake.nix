{
  description = " Custom build of version 6.2 for Foundationdb for NixOS";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-20.03;

  outputs = { self, nixpkgs }: {

    defaultPackage.x86_64-linux =
      # Notice the reference to nixpkgs here.
      with import nixpkgs { system = "x86_64-linux"; };
      stdenv.mkDerivation {
        name = "foundationdb";
        version = "6.2.24";
        requires = [ openssl ];

        src = fetchurl {
            url = "https://github.com/vlche/fdb62/releases/download/v1.0.0/6.2.24.tar.gz";
            sha256 = "ae709b9836c3a9114f484a98c24eb57a8f653461c9d4a847c78d938ee4178123";
        };

        phases = [ "installPhase" ];
        dontUnpack = true;

        installPhase = ''
            mkdir -p $out/bin
            tar -zxvf $src

            for file in `ls -1 bin/` ; do
                patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" bin/$file || true
                install -t $out/bin bin/$file
            done
        '';
      };

  };
}
