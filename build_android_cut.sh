#!/bin/bash
NDK=/Users/rxm/sdk/android-ndk-r17c
SYSROOT=$NDK/platforms/android-21/arch-arm
ISYSROOT=$NDK/sysroot
ASM=$ISYSROOT/usr/include/arm-linux-androideabi
TOOLCHAIN=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64
PREFIX=$(pwd)/android/armv7-a
CROSS_PREFIX=$TOOLCHAIN/bin/arm-linux-androideabi-
build_android()
{
    ./configure \
    --prefix=$PREFIX \
    --disable-shared \
    --enable-static \
    --disable-doc \
    --disable-htmlpages \
    --disable-manpages \
    --disable-podpages \
    --disable-txtpages \
    --disable-ffmpeg \
    --disable-ffplay \
    --disable-network \
    --disable-ffprobe \
    --disable-symver \
    --disable-programs \
    --disable-everything \
    --enable-avdevice \
    --enable-bsfs \
    --enable-filters \
    --enable-decoder=h264 \
    --enable-decoder=aac \
    --enable-decoder=mp3float \
    --enable-decoder=mp3 \
    --enable-decoder=mp2 \
    --enable-decoder=mpeg2video \
    --enable-decoder=mp3_at \
    --enable-decoder=mp3adufloat \
    --enable-decoder=mp3adu \
    --enable-decoder=mp3on4float \
    --enable-decoder=mp3on4 \
    --enable-decoder=pcm_alaw \
    --enable-decoder=pcm_alaw_at \
    --enable-decoder=pcm_f32be \
    --enable-decoder=pcm_f32le \
    --enable-decoder=pcm_f64be \
    --enable-decoder=pcm_f64le \
    --enable-decoder=pcm_mulaw \
    --enable-decoder=pcm_mulaw_at \
    --enable-decoder=pcm_s16be \
    --enable-decoder=pcm_s16be_planar \
    --enable-decoder=pcm_s16le \
    --enable-decoder=pcm_s16le_planar \
    --enable-decoder=pcm_s24be \
    --enable-decoder=pcm_s24daud \
    --enable-decoder=pcm_s24le \
    --enable-decoder=pcm_s24le_planar \
    --enable-decoder=pcm_s32be \
    --enable-decoder=pcm_s32le \
    --enable-decoder=pcm_s32le_planar \
    --enable-decoder=pcm_s64be \
    --enable-decoder=pcm_s64le \
    --enable-decoder=pcm_s8 \
    --enable-decoder=pcm_s8_planar \
    --enable-decoder=pcm_u16be \
    --enable-decoder=pcm_u16le \
    --enable-decoder=pcm_u24be \
    --enable-decoder=pcm_u24le \
    --enable-decoder=pcm_u32be \
    --enable-decoder=pcm_u32le \
    --enable-decoder=pcm_u8 \
    --enable-decoder=pcm_vidc \
    --enable-encoder=h264_videotoolbox \
    --enable-encoder=aac \
    --enable-encoder=mpeg4 \
    --enable-encoder=mpeg2video \
    --enable-encoder=mp2 \
    --enable-encoder=pcm_alaw \
    --enable-encoder=pcm_alaw_at \
    --enable-encoder=pcm_f32be \
    --enable-encoder=pcm_f32le \
    --enable-encoder=pcm_f64be \
    --enable-encoder=pcm_f64le \
    --enable-encoder=pcm_mulaw \
    --enable-encoder=pcm_mulaw_at \
    --enable-encoder=pcm_s16be \
    --enable-encoder=pcm_s16be_planar \
    --enable-encoder=pcm_s16le \
    --enable-encoder=pcm_s16le_planar \
    --enable-encoder=pcm_s24be \
    --enable-encoder=pcm_s24daud \
    --enable-encoder=pcm_s24le \
    --enable-encoder=pcm_s24le_planar \
    --enable-encoder=pcm_s32be \
    --enable-encoder=pcm_s32le \
    --enable-encoder=pcm_s32le_planar \
    --enable-encoder=pcm_s64be \
    --enable-encoder=pcm_s64le \
    --enable-encoder=pcm_s8 \
    --enable-encoder=pcm_s8_planar \
    --enable-encoder=pcm_u16be \
    --enable-encoder=pcm_u16le \
    --enable-encoder=pcm_u24be \
    --enable-encoder=pcm_u24le \
    --enable-encoder=pcm_u32be \
    --enable-encoder=pcm_u32le \
    --enable-encoder=pcm_u8 \
    --enable-encoder=pcm_vidc \
    --enable-parser=h264 \
    --enable-parser=aac \
    --enable-demuxers \
    --enable-muxer=mp4 \
    --enable-muxer=mpegts \
    --enable-muxer=wav \
    --enable-muxer=adts \
    --enable-indev=lavfi \
    --enable-protocols \
    --cross-prefix=$CROSS_PREFIX \
    --target-os=android \
    --arch=arm \
    --enable-cross-compile \
    --sysroot=$SYSROOT \
    --extra-cflags="-I$ASM -isysroot $ISYSROOT -D__ANDROID_API__=21 -Os -fpic -marm -march=armv7-a"
    make clean
    make
    make install

    $TOOLCHAIN/bin/arm-linux-androideabi-ld \
    -rpath-link=$SYSROOT/usr/lib \
    -L$SYSROOT/usr/lib \
    -L$PREFIX/lib \
    -soname libffmpeg.so -shared -nostdlib -Bsymbolic --whole-archive --no-undefined -o \
    $PREFIX/libffmpeg.a \
    $PREFIX/lib/libavcodec.a \
    $PREFIX/lib/libavfilter.a \
    $PREFIX/lib/libswresample.a \
    $PREFIX/lib/libavformat.a \
    $PREFIX/lib/libavutil.a \
    $PREFIX/lib/libswscale.a \
    $PREFIX/lib/libavdevice.a \
    -lc -lm -lz -ldl -llog --dynamic-linker=/system/bin/linker \
    $TOOLCHAIN/lib/gcc/arm-linux-androideabi/4.9.x/libgcc.a \

}
build_android