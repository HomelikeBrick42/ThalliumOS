set -xe

pushd src
	nasm -o ../build/Bootloader16.bin Bootloader16.asm -fbin
	nasm -o ../build/BootloaderExtended16.bin BootloaderExtended16.asm -fbin
popd

cat build/Bootloader16.bin build/BootloaderExtended16.bin > bootloader.bin
