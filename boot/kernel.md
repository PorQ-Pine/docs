# Linux kernel and init ramdisk
## Compiling and running
### Required packages that were not installed at the U-Boot compiling step
Alpine Linux:
```
apk add ncurses-dev flex bison gmp-dev mpc1-dev openssl-dev mpfr-dev findutils perl
```
### Compiling the kernel
```
git clone https://github.com/PorQ-Pine/kernel
pushd kernel
env CROSS_COMPILE=your_toolchains_path- make
```
In the next step, you will need the following files: `arch/arm64/boot/Image.gz` and `arch/arm64/boot/dts/rockchip/rk3566-pinenote-v1.2.dtb`. I put them in `/tmp` for the example below.
### Booting the kernel
Make sure to have the `lrzsz` tools installed and launch `picocom` with the following command:
```
sudo picocom -b 1500000 /dev/ttyXX --send-cmd "sz -vv -Y"
```
Then, in U-Boot's serial console, issue the following commands. After each `loady` invocation, input `CTRL+A` then `S` to make the `*** file:` prompt appear.
```
=> loady ${kernel_addr_c}
## Ready for binary (ymodem) download to 0x04080000 at 1500000 bps...
C
*** file: /tmp/Image.gz
$ sz -vv -Y /tmp/Image.gz
Sending: Image.gz
Bytes Sent:8020736   BPS:89347
Sending:
Ymodem sectors/kbytes sent:   0/ 0k
Transfer complete

*** exit status: 0 ***
2(STX)/0(CAN) packets, 3 retries
## Total Size      = 0x007a628f = 8020623 Bytes
=> loady ${fdt_addr_r}
## Ready for binary (ymodem) download to 0x0A100000 at 1500000 bps...
C
*** file: /tmp/rk3566-pinenote-v1.2.dtb
$ sz -vv -Y /tmp/rk3566-pinenote-v1.2.dtb
Sending: rk3566-pinenote-v1.2.dtb
Bytes Sent:  62464   BPS:6466
Sending:
Ymodem sectors/kbytes sent:   0/ 0k
Transfer complete

*** exit status: 0 ***
STX)/1(CAN) packets, 4 retries
## Total Size      = 0x0000f3ad = 62381 Bytes
=> unzip ${kernel_addr_c} ${kernel_addr_r}
Uncompressed size: 20285952 = 0x1358A00
=> booti 0x00a80000 - 0x0a100000
```
The kernel should now boot.
