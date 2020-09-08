#!/bin/sh

#nix-build -E 'with import <nixpkgs> {} ; callPackage ./default.nix {}' -v 
nix-build -E 'with import <nixpkgs> {} ; callPackage ./default.nix {}' -A foundationdb62 -v -K 2>build.log
