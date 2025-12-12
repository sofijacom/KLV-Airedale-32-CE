#!/bin/bash
# 
# sofiya Created: 12.11.2025 Revised:  Licence: MIT
# version 1.00 -CE-1.0

# General Build Instructions:
# Create an empty directory at root of partition you want to bootfrom
# For example: /KLV_minimal_32bit
# In a terminal opened at that bootfrom directory simply run this single script!!! ;-)

# Fetch the build_firstrib_rootfs build parts:
wget -c https://gitlab.com/sofija.p2018/kla-ot2/-/raw/main/KLV-Airedale-32/modules/build_firstrib_rootfs.sh && chmod +x build_firstrib_rootfs.sh

# rockedge minimal Void Linux build plugin used during the build (you can add to this plugin for whatever extras you want in your build)
wget -c https://gitlab.com/sofija.p2018/kla-ot2/-/raw/main/KLV-Airedale-32/f_00_Void_KLV_XFCE_i686_CE.plug

# Download the boot components:
wget -c https://gitlab.com/sofija.p2018/kla-ot2/-/raw/main/KLV-Airedale-32/kernel-linux-i686/initrd.gz
wget -c https://gitlab.com/sofija.p2018/kla-ot2/-/raw/main/KLV-Airedale-32/kernel-linux-i686/vmlinuz
wget -c https://gitlab.com/sofija.p2018/kla-ot2/-/raw/main/KLV-Airedale-32/kernel-linux-i686/00zdrv_upupnn+bw_24.04.sfs
wget -c https://gitlab.com/sofija.p2018/kla-ot2/-/raw/main/KLV-Airedale-32/kernel-linux-i686/01fdrv_upupnn+bw_24.04.sfs

# Some useful FirstRib utilities in case you want to modify the initrd or the 07firstrib_rootfs
# All these utilities have a --help option
wget -c https://gitlab.com/sofija.p2018/kla-ot2/-/raw/main/KLV-Airedale-32/modules/wd_grubconfig && chmod +x wd_grubconfig  # When run finds correct grub menu stanza for your system
wget -c https://gitlab.com/sofija.p2018/kla-ot2/-/raw/main/KLV-Airedale-32/modules/modify_initrd_gz.sh && chmod +x modify_initrd_gz.sh  # For 'experts' to modify initrd.gz
wget -c https://gitlab.com/sofija.p2018/kla-ot2/-/raw/main/KLV-Airedale-32/modules/mount_chroot.sh && chmod +x mount_chroot.sh  # To enter rootfs in a chroot
wget -c https://gitlab.com/sofija.p2018/kla-ot2/-/raw/main/KLV-Airedale-32/modules/umount_chroot.sh && chmod +x umount_chroot.sh  # to 'clean up mounts used by above mount_chroot.sh'
# wget -c https://gitlab.com/firstrib/firstrib/-/raw/master/latest/build_system/initrd_32bit-latest.gz -O initrd.gz  # FR skeleton initrd for 32bit root filesystem booting
# Optional addon layers

# Main KL addon containing the likes of gtkdialog, filemnt, UExtract, gxmessage, save2flash and more
# save2flash works with command-line-only distros too
wget -c https://gitlab.com/sofija.p2018/kla-ot2/-/raw/main/KLV-Airedale-32/modules/16gtkdialogGTK3_filemnt32.sfs
wget -c https://gitlab.com/sofija.p2018/kla-ot2/-/raw/main/KLV-Airedale-32/modules/10klv_settings_32bit.sfs

# Build the Void Linux root filesystem to firstrib_rootfs directory
# NOTE WELL: If you have an alternative f_plugin in your bootfrom directory (name must start with f_),
# simply alter below command to use it
./build_firstrib_rootfs.sh void default i686 f_00_Void_KLV_XFCE_i686_CE.plug

# Number the layer ready for booting
mv firstrib_rootfs 07firstrib_rootfs

# The only thing now to do is find correct grub stanza for your system
printf "\nPress any key to run utility wd_grubconfig
which will output suitable exact grub stanzas
Use one of these with your pre-installed grub
Press enter to finish\n"
read choice
./wd_grubconfig
exit 0


