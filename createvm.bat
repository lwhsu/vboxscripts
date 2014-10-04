@echo off

PATH C:\Program Files\Oracle\VirtualBox
set VM_FOLDER_PARENT=C:\VirtualBox\VirtualBox VMs

rem TODO: convert these to .bat
rem if [ $# -lt 1 ]; then
rem 	echo "Usage: $0 <VM name>"
rem 	exit 1
rem fi

set VM_NAME=%1
set VM_FOLDER=%VM_FOLDER_PARENT%\%VM_NAME%
set VM_VDI=%VM_FOLDER%\%VM_NAME%.vdi

VBoxManage createvm --name "%VM_NAME%" --ostype "FreeBSD_64" --register

VBoxManage modifyvm "%VM_NAME%" --cpus 2
VBoxManage modifyvm "%VM_NAME%" --chipset ich9
VBoxManage modifyvm "%VM_NAME%" --ioapic on
VBoxManage modifyvm "%VM_NAME%" --rtcuseutc on
VBoxManage modifyvm "%VM_NAME%" --boot1 dvd --boot2 disk --boot3 none --boot4 none
VBoxManage modifyvm "%VM_NAME%" --memory 1024 --vram 8

VBoxManage storagectl "%VM_NAME%" --name "SATA Controller" --add sata --controller IntelAHCI
VBoxManage createhd --filename "%VM_VDI%" --size 32768
VBoxManage storageattach "%VM_NAME%" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "%VM_VDI%"
VBoxManage storageattach "%VM_NAME%" --storagectl "SATA Controller" --port 1 --device 0 --type dvddrive --medium emptydrive

VBoxManage modifyvm "%VM_NAME%" --nic1 nat --nictype1 virtio
VBoxManage modifyvm "%VM_NAME%" --nic2 hostonly --nictype2 virtio --hostonlyadapter2 vboxnet0