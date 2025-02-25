### Creating ISO
We are relying here on the [unattended installation mode of microsoft](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/update-windows-settings-and-scripts-create-your-own-answer-file-sxs?view=windows-11), basically, we need to set up some things on the installation so we have a clean windows **without any bloatware**.

There's a very nice [website](https://schneegans.de/windows/unattend-generator/) that create this `unattended.xml` file according to your taste, it's a totally legitimate way of installing windows, you just need to [burn](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/windows-setup-automation-overview?view=windows-11) this `.xml` inside the [Windows 11 official iso](https://www.microsoft.com/en-us/software-download/windows11).

I force here windows to install without TPM and secure boot, I think that for **my** use case this doesn't matter, but please enable these features if they are relevant to you.

<img src="https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/images/servicing_unattend.png?view=windows-11" width=400> 

There's a lot of possibilities using Microsoft's official tools for this, but for our use can the `unattended.xml` should be enough 

### Installing
The some dial as always, format the only disk that will appear on the installer and authentic your account, i like to use Microsoft's account.

> [!CAUTION]  
>  You should disable the other SSD on the BIOS so Windows's installer don't mess up with Debian

### Pos-install
The script will remove almost all the bloatware on the system, you just need to manually uninstall Microsoft Edge (**yes, you can do it with the script**) and use a [winget](https://learn.microsoft.com/pt-br/windows/package-manager/winget/) script to install the programs.

I'm personally not a PowerShell user so all the permissions issues of running a script appeared very confusing to me. A easy way to install the script is to use `winget install gerardog.gsudo`, that implements a `gsudo <script_file>` that just works.

The programs will start to be installed, as this process happens i recommend to login on your accounts and go to the next section

### Encryption and restore points
Encryption is almost trivial on Windows, just open Bitlocker and follow the guide. The same can be said about restore points

