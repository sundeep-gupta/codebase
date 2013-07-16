mkdir ./ppc
mkdir ./i386

gcc -arch ppc -o ./ppc/a.out $1
gcc $(ARCH) -isysroot /Developer/SDKs/MacOSX10.4u.sdk -arch i386 -o ./i386/a.out $1

/usr/bin/lipo -create -arch ppc ./ppc/a.out -arch i386 ./i386/a.out -output a.out

