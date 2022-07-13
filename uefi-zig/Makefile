qemu: OVMF.fd efi/boot/bootx64.EFI
	qemu-system-x86_64 -nographic -bios OVMF.fd -drive file=fat:rw:.,media=disk,format=raw

OVMF.fd:
	wget http://downloads.sourceforge.net/project/edk2/OVMF/OVMF-X64-r15214.zip
	unzip OVMF-X64-r15214.zip OVMF.fd
	rm OVMF-X64-r15214.zip

clean:
	rm -f OVMF.fd
	rm -rf efi
