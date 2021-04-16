#!/bin/sh

#Grabbing Info from Servers

date=$(date)
host=$(hostname)

printf "$date\n###/etc/fstab###\n" > /tmp/"$host"_patching_log.txt
cat /etc/fstab >> /tmp/"$host"_patching_log.txt
printf "\n\n" >> /tmp/"$host"_patching_log.txt

printf "###df -hT###\n" >> /tmp/"$host"_patching_log.txt
df -hT >> /tmp/"$host"_patching_log.txt
printf "\n\n" >> /tmp/"$host"_patching_log.txt

printf "###lsblk -f###\n" >> /tmp/"$host"_patching_log.txt
lsblk -f >> /tmp/"$host"_patching_log.txt
printf "\n" >> /tmp/"$host"_patching_log.txt

printf "###lsblkASM###\n" >> /tmp/"$host"_patching_log.txt
lsblk -o NAME,FSTYPE,SIZE,TYPE | grep oracleasm >> /tmp/"$host"_patching_log.txt
printf "\n" >> /tmp/"$host"_patching_log.txt

printf "###lsblk -d###\n" >> /tmp/"$host"_patching_log.txt
lsblk -d >> /tmp/"$host"_patching_log.txt
printf "\n\n" >> /tmp/"$host"_patching_log.txt
printf "###\n" >> /tmp/"$host"_patching_log.txt

printf "$date\n###lvs###\n" >> /tmp/"$host"_patching_log.txt
lvs >> /tmp/"$host"_patching_log.txt
printf "\n\n" >> /tmp/"$host"_patching_log.txt

printf "###ifcfg-eth0###\n" >> /tmp/"$host"_patching_log.txt
cat /etc/sysconfig/network-scripts/ifcfg-eth0 >> /tmp/"$host"_patching_log.txt
printf "\n\n" >> /tmp/"$host"_patching_log.txt

printf "###ifcfg-eth1###\n" >> /tmp/"$host"_patching_log.txt
cat /etc/sysconfig/network-scripts/ifcfg-eth1 >> /tmp/"$host"_patching_log.txt
printf "\n\n" >> /tmp/"$host"_patching_log.txt

printf "###IP Address###\n" >> /tmp/"$host"_patching_log.txt
ip address >> /tmp/"$host"_patching_log.txt
printf "\n\n" >> /tmp/"$host"_patching_log.txt

printf "###OS Info###\n" >> /tmp/"$host"_patching_log.txt
cat /etc/*-release >> /tmp/"$host"_patching_log.txt
printf "\n\n" >> /tmp/"$host"_patching_log.txt

printf "###Kernel Info###\n" >> /tmp/"$host"_patching_log.txt
uname -r >> /tmp/"$host"_patching_log.txt
printf "\n\n" >> /tmp/"$host"_patching_log.txt

printf "###Grub_SLink###\n" >> /tmp/"$host"_patching_log.txt
ls -l /etc/grub2.cfg >> /tmp/"$host"_patching_log.txt
printf "\n\n" >> /tmp/"$host"_patching_log.txt

printf "###/etc/grub2.cfg###\n" >> /tmp/"$host"_patching_log.txt
cat /etc/grub2.cfg >> /tmp/"$host"_patching_log.txt
printf "\n\n" >> /tmp/"$host"_patching_log.txt

printf "###Memory Info###\n" >> /tmp/"$host"_patching_log.txt
free -m >> /tmp/"$host"_patching_log.txt
printf "\n\n" >> /tmp/"$host"_patching_log.txt

printf "###CPU Info###\n" >> /tmp/"$host"_patching_log.txt
lscpu >> /tmp/"$host"_patching_log.txt
printf "\n\n" >> /tmp/"$host"_patching_log.txt

printf "###Yum History###\n" >> /tmp/"$host"_patching_log.txt
yum history >> /tmp/"$host"_patching_log.txt
printf "\n\n" >> /tmp/"$host"_patching_log.txt

chmod 644 /tmp/"$host"_patching_log.txt
