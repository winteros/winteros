#!/bin/bash 
loadkeys ru
setfont cyr-sun16
read -p "Пауза 3 ceк." -t 3
echo '2.4.2 Форматирование дисков'
mkfs.ext2  /dev/sda1 -L boot
mkswap /dev/sda2 -L swap
mkfs.ext4  /dev/sda3 -L root
mkfs.ext4  /dev/sda4 -L home
echo '2.4.3 Монтирование дисков'
read -p "Пауза 3 ceк." -t 3
mount /dev/sda3 /mnt
mkdir /mnt/{boot,home}
mount /dev/sda1 /mnt/boot
swapon /dev/sda2
mount /dev/sda4 /mnt/home
echo '3.2 Установка основных пакетов'
read -p "Пауза 3 ceк." -t 3
pacstrap /mnt base base-devel
echo '3.3 Настройка системы'
read -p "Пауза 3 ceк." -t 3
genfstab -pU /mnt >> /mnt/etc/fstab
echo 'Переходим в установлнную систему'
read -p "Пауза 3 ceк." -t 3
arch-chroot /mnt
echo "winterosarch" > /etc/hostname
ln -svf /usr/share/zoneinfo/Asia/Omsk /etc/localtime
echo '3.4 Добавляем русскую локаль системы'
read -p "Пауза 3 ceк." -t 3
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen 
echo 'Обновим текущую локаль системы'
read -p "Пауза 3 ceк." -t 3
locale-gen
echo 'Указываем язык системы'
read -p "Пауза 3 ceк." -t 3
echo 'LANG="ru_RU.UTF-8"' > /etc/locale.conf
echo 'Вписываем KEYMAP=ru FONT=cyr-sun16'
read -p "Пауза 3 ceк." -t 3
echo 'KEYMAP=ru' >> /etc/vconsole.conf
echo 'FONT=cyr-sun16' >> /etc/vconsole.conf
echo 'Создадим загрузочный RAM диск'
read -p "Пауза 3 ceк." -t 3
mkinitcpio -p linux
read -p "Пауза 3 ceк." -t 3
echo 'Создаем root пароль'
passwd
echo '3.5 Устанавливаем загрузчик'
read -p "Пауза 3 ceк." -t 3
pacman -S grub --noconfirm 
grub-install /dev/sda
echo 'Обновляем grub.cfg'
read -p "Пауза 3 ceк." -t 3
grub-mkconfig -o /boot/grub/grub.cfg
read -p "Пауза 3 ceк." -t 3
#echo 'Ставим программу для Wi-fi'
#pacman -S dialog wpa_supplicant --noconfirm
exit
umount /mnt/{boot,home,}
echo 'Перезагружаемся'
read -p "Пауза 3 ceк." -t 3
reboot