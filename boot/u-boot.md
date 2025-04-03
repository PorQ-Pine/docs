# U-Boot
## Compiling and running
### SPL U-Boot (download mode)
I have not yet found out how to boot regular U-Boot via USB download mode. This page will hopefully be updated if a way is found.
<ol>
    <li>
        U-Boot sources are located at https://github.com/PorQ-Pine/u-boot-pinenote. You also have to clone the https://github.com/rockchip-linux/rkbin repository in your root directory.
If you are running on an ARM64 machine (e.g. a Mac + Alpine Linux VM), STOP and run to the nearest x86 computer (note: I didn’t follow this advice).   
    </li>
    <li>
        For Alpine Linux: <code>apk add coreutils dtc python3 py3-elftools</code>
    </li>
    <li>
        Run <code>env CROSS_COMPILE=your_toolchains_path- compile.sh rk3566-pinenote</code> twice, first for regular U-Boot and then a second time by replacing the second argument by the <code>spl</code> argument to build <code>rk356x_spl_loader_v1.20.114.bin</code>.
    </li>
    <li>
        From existing U-Boot, run rockusb 0 mmc 0 to trigger rockusb mode. If you were connected via the serial dongle, quit picocom/minicom cleanly and unplug it. Then, plug an ordinary USB-C cable on the device.
    </li>
    <li>
        On the host, run <code>rkdeveloptool reboot-maskrom</code> to reboot to download mode.
    </li>
    <li>
        Run <code>rkdeveloptool boot rk356x_spl_loader_v1.20.114.bin</code>. To check if it worked, check if <code>rkdeveloptool read-flash-info</code> outputs anything useful.
    </li>
</ol>

### Regular U-Boot
WIP

## Entering fastboot mode
One can enter fastboot mode by issuing <code>fastboot usb 0</code> at the serial console. If you are using the serial dongle, make sure to quit your terminal program cleanly and plug back regular USB to access fastboot.
