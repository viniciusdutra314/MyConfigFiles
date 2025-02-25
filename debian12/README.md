# Manual Partition
> [!CAUTION]  
>  You should disable the other SSD on the BIOS so Windows's installer don't mess up with Debian

I'm basing here on what can be done on the manual partition of the Debian 12 Calamares installer.

This the SSD layout on GParted so you can take a good look, i'll explain each partition on the subsections

<img src=images/partition.png width=500>

### /boot/efi (1GB FAT32)
Active the boot flag, there's a lot of debate over the size of this partition, but 1GB it's enough for sure

###   / (512GB BTRFS Encrypted)
[BTRFS](https://btrfs.readthedocs.io/en/latest/) is a beautiful CopyOnWrite (COW) filesystem that is very easy to create snapshots, deduplication, compression and more! If you use Linux you should take look, i like to think of it as **a git on a filesystem level**

### no mount point (512 GB NTFS)

This partition will be used on Windows to store video editing files and games, i'm using NTFS due to Windows and Linux native support.
I don't encrypt this partition given that the data is not sensitivity, but if you want you may [VeraCrypt](https://www.veracrypt.fr/en/Home.html) to encrypt it and use it both on Windows and Linux

# Manual Pos-install
We will do the interactive sections first, then the unattended ones. I theory everything here can be automatized, but it's simplify easier to do by hand in case of any setup difference

### Swapfile
I like to have more control over my swap, one way is to create a file that will serve as a swap partition, on btrfs we have specific commands for that
```bash
sudo btrfs filesystem mkswapfile --size 16G /swapfile
sudo swapon /swapfile #activate
echo "/swapfile none swap defaults 0 0" | sudo tee /etc/fstab -a # Add to fstab
```
Here we're creating a swapfile on `/swapfile` of 16GB, [you should](https://wiki.manjaro.org/index.php/Swap) generally use between 1x or up 2x the amount of RAM your system has. We activate then write an entry to the `/etc/fstab` file

### Snapshots (Timeshift + grub-btrfs)
It's always a good idea to have the hability to go back in time on your PC and solve any troubled that happend, on Arch based distrubtions this techinique is very common due to the crazy unstability that a rolling release distro may have.


Timeshift is the utility to create the so called snapshots (on btrfs system is really a snapshot), it's easy to install

```bash
sudo apt install timeshift
```
Open the graphical interface, select **btrfs** and the location should be on the same partition Debian is installed.

On this setup if the SSD is erased so are the snapshots, you can make the snapshots on another disk using rsync, but given that snapshots **ARE NOT** a backup, just a convenient way to quickly solve problems, i don't care if my SSD is erased, all my important data is saved on my backup system

Now, we want grub to show these snapshots and provide a easy way to rollback to them, this can be achieve by `grub-btrfs`.

`grub-btrfs` provides a daemon that automatically update our grub menu with the new snapshots taken from timeshift.

There's not Debian package available to this application, so we need to compile it from source ourselves

```bash
git clone https://github.com/Antynea/grub-btrfs.git
cd grub-btrfs/
sudo make install
```

Now we need to activate the daemon 

```bash
sudo apt install inotify-tools #dependency for timeshift to work
sudo systemctl start grub-btrfsd
sudo systemctl enable grub-btrfsd
```

grub-btrfs works by default on snapper but not on timeshift, for timeshift we need to change the config of the deamon a little bit

```bash
sudo systemctl edit --full grub-btrfsd 
```

This will open a config you should change the line that begins with `ExecStart` to ExecStart=/usr/bin/grub-btrfsd --syslog --timeshift-auto.

Them reload everything

```bash
sudo systemctl daemon-reload
sudo systemctl restart grub-btrfsd
```


### Nvidia Drivers
I recommend to create a snapshot  before installing the Nvidia drivers, if anything happens you can rollback to now and also test if the snapshots are indeed working.

On the [Debian wiki](https://wiki.debian.org/NvidiaGraphicsDrivers) we can find more information about how to use the propriety drivers of Nvidia on Debian, we need to change one line on `/etc/apt/sources.list` to what is below, 
we need to append contrib, non-free and non-free-firmware to the original

```
deb http://deb.debian.org/debian/ bookworm main contrib non-free non-free-firmware
```

Them update and install the drivers
```
sudo apt update
sudo apt install nvidia-driver firmware-misc-nonfree
```

### Zsh (Oh My Zsh)
I like to have a beautiful prompt on my terminal, one way to quickly get a gorgeous zsh is using oh my zsh

```bash
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

# Automatic Pos-install
Now we gonna install all the applications that easily can be installed on an unattended manner


# Debloat Debian
I don't like that the Calamares installer installs 
so much games and not so much used applications on Debian. 
If i want some of them i can just go to the Software store and install what i want!.

> [!IMPORTANT]  
> My debloat maybe very aggressive to your taste, so please read the script before executing


```
sudo chmod +x debloat_debian.sh
./debloat_debian.sh
```

# Gnome