#! /bin/bash

export ARCH_DIR=output/$1
export INSTALL_DIR=assets/$1

case "$1" in
    x86)
        ;;
    arm)
        ;;
    x86_64)
        ;;
    arm64)
        ;;
    *)
        echo "unsupported architecture"
        exit
        ;;
esac

rm -rf $ARCH_DIR/release
mkdir -p $ARCH_DIR/release
cp assets/all/* $ARCH_DIR/release/
cp $INSTALL_DIR/* $ARCH_DIR/release/
rm $ARCH_DIR/release/assets.txt
cat $ARCH_DIR/release/rootfs.tar.gz.part* > $ARCH_DIR/$1-rootfs.tar.gz
rm $ARCH_DIR/release/rootfs.tar.gz.part*
rm -f $ARCH_DIR/assets.txt; for f in $(ls $ARCH_DIR/release/); do echo "$f $(date +%s -r $ARCH_DIR/release/$f) $(md5sum $ARCH_DIR/release/$f | awk '{ print $1 }')" >> $ARCH_DIR/assets.txt; done
echo "rootfs.tar.gz $(date +%s -r $ARCH_DIR/$1-rootfs.tar.gz) $(md5sum $ARCH_DIR/$1-rootfs.tar.gz | awk '{ print $1 }')" >> $ARCH_DIR/assets.txt
tar -czvf $ARCH_DIR/$1-assets.tar.gz -C $ARCH_DIR/release/ .
