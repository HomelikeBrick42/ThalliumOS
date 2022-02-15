set -xe

mkdir -p build

pushd src
	nasm -o ../build/Bootloader16.bin Bootloader16.asm -fbin
	nasm -o ../build/BootloaderExtended.bin BootloaderExtended.asm -fbin
popd

cat build/Bootloader16.bin build/BootloaderExtended.bin > bootloader.bin
