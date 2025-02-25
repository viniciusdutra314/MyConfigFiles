# MyPC

All the configs necessary to turn my Nitro 5 laptop in a working laptop for my personal use. I'm writing down all these details first all so i can quickly use this as a reference to my future self, second, so people can use this as a base for these personal uses

# Dualboot

### Two SSD's
I have two SSD's (1TB and 256GB), so i can install each operational system on a different SSD, this significantly improves reliability because it's very rare that each system messes up with other. Nonetheless, **you should disable the others SSD in the BIOS settings when you are installing the other system**, in this way you have guaranteed that during the installation process all the boot partitions work as expected.

### Debian 12 and Windows 11
On the main SSD (1TB) i have Debian install, for me it's one of the best Linux distributions for my use, because it's incredibly stable because of the delay on new packages, and has a great compatibility given that is the base for the distributions that most users use.

Windows 11 is the system that i can play my games and edit my videos without any troubles, with proton and DaVinci Resolve you can also do these things on Linux, but i want something that gets out the most of the performance of my laptop and it's reliable.

[Install Windows 11](./windows11/README.md)


[Install Debian 12](./debian12/README.md)

### Debugging
Creating this scripts and being sure that they work it's very hard. I found two ways that provide a way of debugging that is not so time consuming

- Restore points: Testing the post installation scripts can be done creating a restore point on a fresh installation, so you can always restore to the point before the script was ran
- Virtual Machines: You can replicate most of your hardware on a VM, on [VirtualBox](https://www.virtualbox.org/) you can add multiple small sized disks to replicate whatever you want (including the different between a HD/SSD/NVME), be sure to run on the UEFI mode and not on the BIOS mode