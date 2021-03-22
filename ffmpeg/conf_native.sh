echo "Configure for native build"

FFSRC=`pwd`

RPI_OPT_VC=/opt/vc
RPI_INCLUDES="-I/usr/include -I$RPI_OPT_VC/include -I$RPI_OPT_VC/include/interface/vcos/pthreads -I$RPI_OPT_VC/include/interface/vmcs_host/linux"
RPI_LIBDIRS="-L$RPI_OPT_VC/lib"
RPI_DEFINES="-D__VCCOREVER__=0x4000000 -mfpu=neon-vfpv4"
#RPI_KEEPS="-save-temps=obj"
RPI_KEEPS=""

SHARED_LIBS="--enable-shared"
if [ "$1" == "--no-shared" ]; then
  SHARED_LIBS="--disable-shared"
  OUT=out/armv7-static-rel
  echo Static libs
else
  echo Shared libs
  OUT=out/armv7-shared-rel
fi

USR_PREFIX=$FFSRC/$OUT/install
LIB_PREFIX=$USR_PREFIX/lib/arm-linux-gnueabihf
INC_PREFIX=$USR_PREFIX/include/arm-linux-gnueabihf

mkdir -p $FFSRC/$OUT/install
cd $FFSRC/$OUT

$FFSRC/configure \
 --prefix=$USR_PREFIX\
 --libdir=$LIB_PREFIX\
 --incdir=$INC_PREFIX\
 --disable-stripping\
 --disable-thumb\
 --enable-mmal\
 --enable-rpi\
 --enable-v4l2-request\
 --enable-libdrm\
 --enable-libudev\
 --enable-vout-drm\
 --enable-nonfree\
 $SHARED_LIBS\
 --extra-cflags="-ggdb $RPI_KEEPS $RPI_DEFINES $RPI_INCLUDES"\
 --extra-cxxflags="$RPI_DEFINES $RPI_INCLUDES"\
 --extra-ldflags="$RPI_LIBDIRS"\
 --extra-libs="-Wl,--start-group -lbcm_host -lmmal -lmmal_util -lmmal_core -lvcos -lvcsm -lvchostif -lvchiq_arm"\
 --enable-decoder=hevc_rpi\
 --enable-gpl\
 --enable-libmp3lame\
 --enable-libopenjpeg\
 --enable-librsvg\
 --enable-libvidstab\
 --enable-libvpx\
 --enable-libwavpack\
 --enable-libwebp\
 --enable-libx265\
 --enable-libxml2\
 --enable-libxvid\
 --enable-libzmq\
 --enable-omx\
 --enable-omx-rpi\
 --enable-chromaprint\
 --enable-libx264\
 --arch=armv71\
 --cpu=cortex-a7\

# gcc option for getting asm listing
# -Wa,-ahls
