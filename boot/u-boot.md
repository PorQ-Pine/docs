# U-Boot
## Compiling and running

<ol>
    <li>
        U-Boot sources are located at https://github.com/PorQ-Pine/u-boot-pinenote. You also have to clone the https://github.com/rockchip-linux/rkbin repository in your root directory.
If you are running on an ARM64 machine (e.g. a Mac + Alpine Linux VM), STOP and run to the nearest x86 computer (note: I didn’t follow this advice).   
    </li>
    <li>
        For Alpine Linux: `apk add coreutils dtc python3 py3-elftools`
    </li>
    <li>
        Run `env CROSS_COMPILE=your_toolchains_path- compile.sh` twice, first for regular U-Boot and then a second time by adding the `spl` argument to build `rk356x_spl_loader_v1.20.114.bin`.
    </li>
    <li>
        From existing U-Boot, run rockusb 0 mmc 0 to trigger rockusb mode. If you were connected via the serial dongle, quit picocom/minicom cleanly and unplug it. Then, plug an ordinary USB-C cable on the device.
    </li>
    <li>
        On the host, run `rkdeveloptool reboot-maskrom` to reboot to download mode.
    </li>
    <li>
        Run `rkdeveloptool boot rk356x_spl_loader_v1.20.114.bin`. To check if it worked, check if `rkdeveloptool read-flash-info` outputs anything useful.
    </li>
</ol>
