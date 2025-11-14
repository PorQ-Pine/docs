[This](./graph.png) shows pretty much how it's done

How to read it:
- 🪶 Means it's written/designed from ground up / modified heavily just for the pinenote. I just wanted to see how much things we create and how much we reuse
- 🦀 Means it's written in rust, I was curious how much is rust (Not like other tools are worse, I it's just my curiosity sir)

Also, the graph makes more sense once you understand the partition table we modified:
- p0-p4 we don't touch, we only backup, flash uboot and flash uboot boot partition with images and UMS kernel
- p5 - debian
- p6 - debian home stuff (moved and resized here)
- p7 - quill recovery containing kernel, firmware and maybe local rootfs release backup? (max 4G for now let's say) (ext4)
- p8 - quill normal containing rootfs and user data (ext4)

So like, we have more space to work with and we don't need to share home with an unknown system. (Also old debian is still fully usable after that)
