# luzifer-docker / fhem

This image contains an installation of [FHEM](https://fhem.de/) house automation software.

## Usage

```bash
## Build container (optional)
$ docker build -t luzifer/fhem .

## Supply config and optionally custom modules
$ tree
.
├── config.cfg
└── custom-modules
    └── 32_fitbit.pm

1 directory, 2 files


## Execute curator
$ docker run --rm -ti -v $(pwd):/data -p 8083:8083 luzifer/fhem
```
