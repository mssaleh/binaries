sudo apt update && sudo apt install -y \
autoconf automake autotools-dev cmake cmake-data comerr-dev flite1-dev frei0r-plugins-dev \
ghc gir1.2-freedesktop gir1.2-gdkpixbuf-2.0 gir1.2-harfbuzz-0.0 gir1.2-ibus-1.0 gir1.2-rsvg-2.0 \
icu-devtools krb5-multidev ladspa-sdk libaom-dev libasound2-dev libass-dev libauthen-sasl-perl \
libavutil-dev libblkid-dev libbs2b-dev libbsd-dev libcaca-dev libcairo-script-interpreter2 \
libcairo2-dev libcdio-cdda-dev libcdio-dev libcdio-paranoia-dev libchromaprint-dev libcodec2-dev \
libcurl4-gnutls-dev libdata-dump-perl libdc1394-25 libdc1394-dev libdrm-dev libegl-dev \
libegl1-mesa-dev libencode-locale-perl libfdk-aac-dev libfile-listing-perl libfont-afm-perl \
libfontconfig1-dev libfreetype-dev libfreetype6-dev libfribidi-dev libgdk-pixbuf2.0-dev \
libghc-gnutls-dev libghc-monads-tf-dev libgl-dev libgl1-mesa-dev libgles-dev libgles1 \
libgles2-mesa-dev libglib2.0-dev libglib2.0-dev-bin libglu1-mesa libglu1-mesa-dev libglvnd-dev \
libglx-dev libgme-dev libgmp-dev libgmpxx4ldbl libgnutls-dane0 libgnutls-openssl27 \
libgnutls28-dev libgnutlsxx28 libgraphite2-dev libgsm1-dev libgsmme-dev libgsmme1v5 libgssrpc4 \
libharfbuzz-dev libharfbuzz-gobject0 libharfbuzz-icu0 libhtml-form-perl libhtml-format-perl \
libhtml-parser-perl libhtml-tagset-perl libhtml-tree-perl libhttp-cookies-perl \
libhttp-daemon-perl libhttp-date-perl libhttp-message-perl libhttp-negotiate-perl libibus-1.0-5 \
libibus-1.0-dev libice-dev libice6 libicu-dev libidn2-dev libiec61883-dev libio-html-perl \
libio-socket-ssl-perl libjack-jackd2-dev libjsoncpp1 libkadm5clnt-mit11 libkadm5srv-mit11 \
libkdb5-9 libkrb5-dev liblilv-dev libltdl-dev liblwp-mediatypes-perl liblwp-protocol-https-perl \
libmailtools-perl libmfx-dev libmount-dev libmp3lame-dev libmpg123-dev libmysofa-dev \
libncurses-dev libncurses5-dev libnet-http-perl libnet-smtp-ssl-perl libnorm-dev libnuma-dev \
libogg-dev libomxil-bellagio-bin libomxil-bellagio-dev libomxil-bellagio0 libopenal-dev \
libopengl-dev libopengl0 libopenjp2-7-dev libopenmpt-dev libopus-dev libout123-0 libp11-kit-dev \
libpcre16-3 libpcre2-16-0 libpcre2-32-0 libpcre2-dev libpcre2-posix2 libpcre3-dev \
libpcre32-3 libpcrecpp0v5 libpgm-dev libpixman-1-dev libpng-dev libpng-tools libpthread-stubs0-dev \
libpulse-dev libpulse-mainloop-glib0 libraw1394-dev libraw1394-tools librhash0 librsvg2-dev \
librubberband-dev libsdl2-dev libselinux1-dev libsepol1-dev libserd-dev libset-scalar-perl \
libshine-dev libslang2-dev libsm-dev libsm6 libsnappy-dev libsndio-dev libsodium-dev \
libsord-dev libsoxr-dev libspeex-dev libsratom-dev libssh-dev libssl-dev libswresample-dev \
libswscale-dev libtasn1-6-dev libtasn1-doc libtext-unidecode-perl libtheora-dev libtimedate-perl \
libtool libtry-tiny-perl libtwolame-dev libunbound8 liburi-perl libva-dev libva-glx2 \
libvdpau-dev libvidstab-dev libvorbis-dev libvpx-dev libwavpack-dev libwayland-bin libwayland-dev \
libwebp-dev libwww-perl libwww-robotrules-perl libx11-dev libx264-dev libx265-dev \
libxau-dev libxcb-render0-dev libxcb-shape0-dev libxcb-shm0-dev libxcb-xfixes0-dev libxcb1-dev \
libxcursor-dev libxdmcp-dev libxext-dev libxfixes-dev libxi-dev libxinerama-dev \
libxkbcommon-dev libxml-libxml-perl libxml-namespacesupport-perl libxml-parser-perl libxml-sax-base-perl \
libxml-sax-expat-perl libxml-sax-perl libxml2-dev libxrandr-dev libxrender-dev \
libxss-dev libxt-dev libxt6 libxv-dev libxvidcore-dev libxxf86vm-dev libzmq3-dev libzvbi-dev \
lv2-dev m4 nasm nettle-dev ocl-icd-opencl-dev opencl-c-headers tex-common texinfo uuid-dev \
x11proto-core-dev x11proto-dev x11proto-input-dev x11proto-randr-dev x11proto-scrnsaver-dev \
x11proto-xext-dev x11proto-xf86vidmode-dev x11proto-xinerama-dev xml2 xorg-sgml-doctools \
xtrans-dev yasm libxml2 libflite1 libgsm1 libssl-dev \
&& \
mkdir -p ~/ffmpeg_sources ~/bin \
&& \
cd ~/ffmpeg_sources \
&& \
wget -O ffmpeg-4.2.3.tar.bz2 https://ffmpeg.org/releases/ffmpeg-4.2.3.tar.bz2 \
&& \
tar xjvf ffmpeg-4.2.3.tar.bz2 \
&& \
cd ffmpeg-4.2.3 \
&& \
PATH="/usr/local/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure \
 --toolchain=hardened \
 --prefix="$HOME/ffmpeg_build" \
 --pkg-config-flags=" --static" \
 --extra-cflags="-I$HOME/ffmpeg_build/include" \
 --extra-ldflags="-L$HOME/ffmpeg_build/lib" \
 --extra-libs="-lpthread -lm" \
 --bindir="/usr/local/bin" \
 --enable-swresample \
 --enable-swscale \
 --enable-chromaprint \
 --enable-frei0r \
 --enable-gpl \
 --enable-ladspa \
 --enable-libaom \
 --enable-libass \
 --enable-libbs2b \
 --enable-libcaca \
 --enable-libcdio \
 --enable-libcodec2 \
 --enable-libdc1394 \
 --enable-libdrm \
 --enable-libfdk-aac \
 --enable-libflite \
 --enable-libfontconfig \
 --enable-libfreetype \
 --enable-libfribidi \
 --enable-libgme \
 --enable-libgsm \
 --enable-libjack \
 --enable-libmfx \
 --enable-libmp3lame \
 --enable-libmysofa \
 --enable-libopenjpeg \
 --enable-libopenmpt \
 --enable-libopus \
 --enable-libpulse \
 --enable-librsvg \
 --enable-librubberband \
 --enable-libshine \
 --enable-libsnappy \
 --enable-libsoxr \
 --enable-libspeex \
 --enable-libssh \
 --enable-libtheora \
 --enable-libtwolame \
 --enable-libvidstab \
 --enable-libvorbis \
 --enable-libvpx \
 --enable-libwavpack \
 --enable-libwebp \
 --enable-libx264 \
 --enable-libx265 \
 --enable-libxvid \
 --enable-libzmq \
 --enable-libzvbi \
 --enable-lv2 \
 --enable-nonfree \
 --enable-omx \
 --enable-openal \
 --enable-opencl \
 --enable-opengl \
 --enable-openssl \
 --enable-sdl2 \
 --enable-shared \
 --enable-vaapi \
&& \
PATH="/usr/local/bin:$PATH" make -j $(nproc) \
&& \
sudo make install \
&& \
hash -r \
&& \
sudo apt purge -y \
autoconf automake autotools-dev cmake cmake-data comerr-dev flite1-dev frei0r-plugins-dev \
ghc gir1.2-freedesktop gir1.2-gdkpixbuf-2.0 gir1.2-harfbuzz-0.0 gir1.2-ibus-1.0 gir1.2-rsvg-2.0 \
icu-devtools krb5-multidev ladspa-sdk libaom-dev libasound2-dev libass-dev libauthen-sasl-perl \
libavutil-dev libblkid-dev libbs2b-dev libbsd-dev libcaca-dev libcairo-script-interpreter2 \
libcairo2-dev libcdio-cdda-dev libcdio-dev libcdio-paranoia-dev libchromaprint-dev libcodec2-dev \
libcurl4-gnutls-dev libdata-dump-perl libdc1394-25 libdc1394-dev libdrm-dev libegl-dev \
libegl1-mesa-dev libencode-locale-perl libfdk-aac-dev libfile-listing-perl libfont-afm-perl \
libfontconfig1-dev libfreetype-dev libfreetype6-dev libfribidi-dev libgdk-pixbuf2.0-dev \
libghc-gnutls-dev libghc-monads-tf-dev libgl-dev libgl1-mesa-dev libgles-dev libgles1 \
libgles2-mesa-dev libglib2.0-dev libglib2.0-dev-bin libglu1-mesa libglu1-mesa-dev libglvnd-dev \
libglx-dev libgme-dev libgmp-dev libgmpxx4ldbl libgnutls-dane0 libgnutls-openssl27 \
libgnutls28-dev libgnutlsxx28 libgraphite2-dev libgsm1-dev libgsmme-dev libgsmme1v5 libgssrpc4 \
libharfbuzz-dev libharfbuzz-gobject0 libharfbuzz-icu0 libhtml-form-perl libhtml-format-perl \
libhtml-parser-perl libhtml-tagset-perl libhtml-tree-perl libhttp-cookies-perl \
libhttp-daemon-perl libhttp-date-perl libhttp-message-perl libhttp-negotiate-perl libibus-1.0-5 \
libibus-1.0-dev libice-dev libice6 libicu-dev libidn2-dev libiec61883-dev libio-html-perl \
libio-socket-ssl-perl libjack-jackd2-dev libjsoncpp1 libkadm5clnt-mit11 libkadm5srv-mit11 \
libkdb5-9 libkrb5-dev liblilv-dev libltdl-dev liblwp-mediatypes-perl liblwp-protocol-https-perl \
libmailtools-perl libmfx-dev libmount-dev libmp3lame-dev libmpg123-dev libmysofa-dev \
libncurses-dev libncurses5-dev libnet-http-perl libnet-smtp-ssl-perl libnorm-dev libnuma-dev \
libogg-dev libomxil-bellagio-bin libomxil-bellagio-dev libomxil-bellagio0 libopenal-dev \
libopengl-dev libopengl0 libopenjp2-7-dev libopenmpt-dev libopus-dev libout123-0 libp11-kit-dev \
libpcre16-3 libpcre2-16-0 libpcre2-32-0 libpcre2-dev libpcre2-posix2 libpcre3-dev \
libpcre32-3 libpcrecpp0v5 libpgm-dev libpixman-1-dev libpng-dev libpng-tools libpthread-stubs0-dev \
libpulse-dev libpulse-mainloop-glib0 libraw1394-dev libraw1394-tools librhash0 librsvg2-dev \
librubberband-dev libsdl2-dev libselinux1-dev libsepol1-dev libserd-dev libset-scalar-perl \
libshine-dev libslang2-dev libsm-dev libsm6 libsnappy-dev libsndio-dev libsodium-dev \
libsord-dev libsoxr-dev libspeex-dev libsratom-dev libssh-dev libssl-dev libswresample-dev \
libswscale-dev libtasn1-6-dev libtasn1-doc libtext-unidecode-perl libtheora-dev libtimedate-perl \
libtool libtry-tiny-perl libtwolame-dev libunbound8 liburi-perl libva-dev libva-glx2 \
libvdpau-dev libvidstab-dev libvorbis-dev libvpx-dev libwavpack-dev libwayland-bin libwayland-dev \
libwebp-dev libwww-perl libwww-robotrules-perl libx11-dev libx264-dev libx265-dev \
libxau-dev libxcb-render0-dev libxcb-shape0-dev libxcb-shm0-dev libxcb-xfixes0-dev libxcb1-dev \
libxcursor-dev libxdmcp-dev libxext-dev libxfixes-dev libxi-dev libxinerama-dev \
libxkbcommon-dev libxml-libxml-perl libxml-namespacesupport-perl libxml-parser-perl libxml-sax-base-perl \
libxml-sax-expat-perl libxml-sax-perl libxml2-dev libxrandr-dev libxrender-dev \
libxss-dev libxt-dev libxt6 libxv-dev libxvidcore-dev libxxf86vm-dev libzmq3-dev libzvbi-dev \
lv2-dev m4 nasm nettle-dev ocl-icd-opencl-dev opencl-c-headers tex-common texinfo uuid-dev \
x11proto-core-dev x11proto-dev x11proto-input-dev x11proto-randr-dev x11proto-scrnsaver-dev \
x11proto-xext-dev x11proto-xf86vidmode-dev x11proto-xinerama-dev xml2 xorg-sgml-doctools \
xtrans-dev yasm \
&& \
sudo apt purge ffmpeg && sudo apt autoremove  --purge -y && sudo apt autoclean && sudo apt clean \
&& \
sudo rm -R ~/ffmpeg_build/* ~/ffmpeg_sources/* ~/.cache/*
