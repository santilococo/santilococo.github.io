---
layout: page
title: BottlerOS
description: Basic operative system.
importance: 1
github: https://github.com/slococo/BottlerOS
category: university
---

## Requirements

You must install `nasm`, `qemu`, `gcc` and `make`. These are available in the repository of the vast majority of Linux/macOS distributions.

Debian/Ubuntu: `apt install nasm qemu gcc make`\
macOS (with [homebrew](https://brew.sh/)): `brew install nasm qemu gcc make`

If you have another distribution check how to do it. 

## Compilation

To compile all the files, the `build.sh` script must be executed (from the root folder of the project). Note that you can pass `buddy` as an argument if you want to compile with this memory manager (it won't compile with it by default). Also, if you want to test the OS with the Spanish keyboard, you can do so by passing `spanish` as an argument. Lastly, the `free` parameter will free memory (that has been obtained via `malloc`) on terminating or `killing` a process. 

```
./build.sh
```

This script will do a `make` on the `Toolchain` folder and then a `make` on the project's `root` folder. Then, depending on the parameter entered, it will do: `make all`, `make spanish`, `make buddy` or `make free`. 

## Execution

Now, you will be able to run BottlerOS by doing:

```
./run.sh
```

If, instead, you want to run the OS from Windows, you can do so with: 

```
./run.bat
```

## Tests

In order to perform a static analysis of the system you must have [cppcheck](http://cppcheck.net/) and [pvs-studio](https://pvs-studio.com/) installed. Then, you can run the tests with: 

```
make test
```