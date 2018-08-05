list current disk space allocation
```
df -h
```
check disk paritions
```
fdisk -l
```
change partition size & type
```
fdisk /dev/sda
8e
...
```
extend existing LVM
```
lvextend -L+100GB/dev/mapper/centos-root
```
