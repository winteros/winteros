#!/bin/bash
echo "winterosarch" > /etc/hostname
ln -svf /usr/share/zoneinfo/Asia/Omsk /etc/localtime
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
echo 'LANG="en_US.UTF-8"' > /etc/locale.conf
echo 'KEYMAP=en' >> /etc/vconsole.conf
mkinitcpio -p linux
echo 'Create root password'
passwd
pacman -S grub --noconfirm 
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
read -p "Pause 3 sec." -t 3
#echo 'Ставим программу для Wi-fi'
#pacman -S dialog wpa_supplicant --noconfirm
exit
umount /mnt/{boot,home,}
echo 'Reboot'
read -p "Pause 3 sec." -t 3
reboot
