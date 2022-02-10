---
layout: page
title: BottlerOS
description: Basic operative system.
img:
importance: 1
github: https://github.com/slococo/BottlerOS
category: university
---

## Requisitos <a name="requisitos"></a>

Debe instalar nasm, qemu, gcc, make. Estos se encuentran disponibles en el repositorio de la vasta mayoría de distribuciones de Linux/macOS.

Debian/Ubuntu: `apt install nasm qemu gcc make`\
macOS (con [homebrew](https://brew.sh/)): `brew install nasm qemu gcc make`

Si tiene otra distribución consulte cómo hacerlo.

## Compilación <a name="compilación"></a>

Para compilar todos los archivos se debe ejecutar el script `build.sh` (desde la carpeta raíz del proyecto). Note que usted podrá pasarle como argumento `buddy` si desea compilar con este memory manager (por defecto no compilará con este). Además, si quiere probar el OS con el teclado en español lo podrá hacer pasandole como argumento `spanish`. Por último, el parámetro `free` liberará la memoria (que haya sido obtenida mediante `malloc`) al terminar o hacer `kill` de un proceso.   

```bash
./build.sh
```

Este script hará un `make` en la carpeta de `Toolchain` y luego un `make` en la carpeta `root` del proyecto. Luego, dependiendo del parámetro ingresado hará: `make all`, `make spanish`, `make buddy` o `make free`.

## Ejecución <a name="ejecución"></a>

Ahora, usted podrá ejecutar BottlerOS haciendo:

```bash
./run.sh
```

Si, en su defecto, usted quiere correr el OS desde windows lo podrá hacer con:

```bash
./run.bat
```

## Testeos <a name="tests"></a>

En orden de realizar un análisis estático del sistema usted debe tener instalado [cppcheck](http://cppcheck.net/) y [pvs-studio](https://pvs-studio.com/). Luego, puede correrlos con:

```bash
make test
```