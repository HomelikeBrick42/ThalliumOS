set -xe

mkdir -p build

BuildDir=`pwd`/build

pushd src
	pushd bootloader
		nasm -o $BuildDir/Bootloader16.bin Bootloader16.asm -fbin
		nasm -o $BuildDir/BootloaderExtended.bin BootloaderExtended.asm -fbin
	popd
popd

cat $BuildDir/Bootloader16.bin $BuildDir/BootloaderExtended.bin > Bootloader.bin
