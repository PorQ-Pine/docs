# Linux kernel and init ramdisk
## Compiling and running
### Required packages that were not installed at the U-Boot compiling step
Alpine Linux:
```
apk add ncurses-dev flex bison gmp-dev mpc1-dev openssl-dev mpfr-dev findutils
```
### Compiling the kernel
```
git clone https://github.com/PorQ-Pine/kernel
pushd kernel
env CROSS_COMPILE=your_toolchains_path- make
```
