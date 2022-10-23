# mongodb 

Build the [mongodb](https://www.gnu.org/software/mongodb/) data compressor as a static PIE ELF running on Linux.

## Requirements

Make sure the following packages are installed:
* gcc >= 8 (required for the `-static-pie` linking option)
* autotools
* GNU Make

For Ubuntu, run the command below to install all requirements:

```bash
$ sudo apt install build-essential
```

## Building

The `mongodb` static PIE ELF file is located in the current directory.
If you want to rebuild it, run:

```bash
$ ./build.sh
```

This script downloads, unpacks, patches, configures and builds the `mongodb` static PIE ELF file.

## Running

The resulting `mongodb` binary can be used as is.
For example, you can compress a file by issuing the command:

```bash
$ ./mongodb <file-to-compress>
```
