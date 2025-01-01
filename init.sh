#!/bin/bash
cat<<EOL>resolv.conf
nameserver 8.8.8.8
nameserver 8.8.4.4
EOL

cat<<EOL>hosts
127.0.0.1 localhost
EOL

cat<<EOL>locale.conf
LANG=en_US.UTF-8
EOL

cat<<EOL>.bashrc
#!/bin/bash
clear
neofetch
EOL

chmod +x /.bashrc

mv -vf resolv.conf /etc/resolv.conf
mv -vf hosts /etc/hosts
mv -vf locale.conf /etc/locale.conf

apt update
apt upgrade -y
apt install -y wget nano neofetch sudo git net-tools
echo "next"

groupadd storage
groupadd wheel
useradd -m -g users -G wheel,audio,video,storage,aid_inet -s /bin/bash max
echo "SET YOUR PASSWORD"
passwd max

sed -i '$ a\max ALL=(ALL:ALL) ALL' /etc/sudoers
sed -i '$ a\https://ftp.de.debian.org/debian sid main' /etc/apt/sources.list
sed -i '$ a\https://ftp.us.debian.org/debian sid main' /etc/apt/sources.list
apt update

apt install neofetch

echo done
