## vlche/fdb62
__1__

To build Foundationdb 6.2.24 from sources, do
```
git clone https://github.com/vlche/fdb62
cd fdb62
./build.sh
```
__2__

To get precompiled binaries, download:

https://github.com/vlche/fdb62/releases/download/v1.0.0/6.2.24.tar.gz

__3__

To run flake:

```
 nix shell github:vlche/fdb62 --command fdbcli -v
```
