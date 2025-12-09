We will focus how to fully update everything, as my time is limited to explain how to do partial updates, they are hard to do anyway and easy to mess up anyway

This is update from source, so not the final goal how quill os will update, but for now we have this

First, pull everything, as in this cool button:

<img width="118" height="17" alt="image" src="https://github.com/user-attachments/assets/6fc37002-d39f-4271-af2a-11b2c5d14edf" />

Then, compile kernel and stuff:
```
rq -a -i -b boot_partition
```

Then, rootfs.
```
rq -c rootfs
rq -g rootfs
rq -a -i -b rootfs
```

Then, expose the pinenote over mmc (so boot ums kernel, make sure not partiton is mounted automatically, etc)

then, simply
```
rq -d boot_partition
```

Now the hard part, and a lot of disclaimers

## The next steps, if done badly, can remove your changes / data on the system

# So read carefully

This command, which is next to execute **do not execute it yet, read everything** (Also in expose mmc mode)
```
rq -d rootfs
```
Will ask you: `Do you want to also clean out RW rootfs` - This will clean all changes to the system, all users created. Generally only we (devs of Quill) know if this is needed or not.

You could skip this step, but generally you shouldn't. If something doesn't work after the update, that's the first thing you need to retry and do. If you do it, I propose you back up things, like installed packaged, custom configurations in /etc or something, then, restore them

After doing this step, you need to apply configurations to your home directory, so boot the OS and via serial, login to root and:

If you cleared rootfs, do (Replace szybet everywhere with your username):
```
useradd szybet
passwd szybet
```

(Even tho if you don't cleaned RW rootfs, you should still do this step, at least partially like I described):

Then do 
- but `rm -rf /home/szybet/.*` will remove all your personal configurations. You can generally skip this step, if not, backup things!
- but `cp -r /etc/skel/.* /home/szybet/` will overwrite configs you changed that we manage (so xournalpp, eww...), I think you should still apply it, maybe back up your changes, then restore them manually via gui

```
gocryptfs /home/.szybet /home/szybet
# This will remove your configurations!
rm -rf /home/szybet/.*
cp -r /etc/skel/.* /home/szybet/
sudo chown -R szybet:szybet /home/szybet # Important permissions
umount /home/szybet
```
Then you can log in
