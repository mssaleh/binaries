echo "=========================="
echo "  OS Update and Clean-up  "
echo "=========================="
sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y --purge && sudo apt autoclean && sudo apt clean
sudo snap remove lxd
sudo snap remove core18
sudo snap remove snapd
sudo apt purge -y snapd lxd-agent-loader ubuntu-advantage-tools multipath-tools landscape-common

echo "=========================="
echo " Install Useful Packages "
echo "=========================="
read -p "Do you wish to install some useful packages? (Y)es (N)o (A)bort...   " yn1
case $yn1 in
    Y|y|yes) 
        echo "Installing packages"
        sudo apt install -y \
        adduser alac-decoder alsa-firmware-loaders alsa-utils apparmor-utils apport apt apt-offline \
        apt-show-versions apt-transport-https apt-utils at avahi-daemon base-files base-passwd \
        bash bcache-tools btrfs-progs build-essential byobu bzip2 ca-certificates cloud-guest-utils \
        cloud-init cloud-initramfs-copymods cloud-initramfs-dyn-netconf console-setup curl dash dbus \
        debconf debconf-i18n diffutils dirmngr e2fsprogs efibootmgr eject ethtool faac \
        fdisk ffmpeg findutils firmware-b43-installer fonts-ubuntu-console frei0r-plugins fwupd \
        gdisk git gnupg gnupg2 gnupg-agent grep grub-efi-amd64 grub-efi-amd64-signed gstreamer1.0-alsa \
        gstreamer1.0-plugins-bad gstreamer1.0-plugins-good gstreamer1.0-plugins-rtp gstreamer1.0-pulseaudio \
        gstreamer1.0-rtsp gzip hddtemp hostname htop hwinfo init intel-gpu-tools \
        intel-media-va-driver-non-free intel-opencl-icd iproute2 iputils-ping isc-dhcp-client jq kbd \
        kmod less libasound2-plugins-extra libauthen-pam-perl libavahi-compat-libdnssd-dev libavdevice58 \
        libavfilter-extra libavresample4 libavresample4  libcdio-cdda2 libcdio-cdda2  libcdio-paranoia2 \
        libcdio-paranoia2  libdebconfclient0 libfdisk1 libfdk-aac1 libffi-dev libio-pty-perl libmfx1 \
        libmfx1 libnet-ssleay-perl libpam-runtime libpython3-dev libsodium23 libsoxr-lsr0 libsoxr-lsr0 \
        libudev-dev libwebpdemux2 linux-generic lm-sensors locales lsb-release lsmount lvm2 \
        mawk mdadm mediainfo mesa-utils-extra mount ncdu ncurses-base ncurses-bin netbase netcat-openbsd \
        netplan.io nvme-cli open-iscsi openjdk-8-jdk-headless openjdk-8-jre-headless openssh-server \
        openssl open-vm-tools overlayroot passwd patch perl pkg-config pollinate procps \
        python3 python3-dev python3-nacl python3-pip \
        python3-pymacaroons rsyslog screen sensible-utils shim-signed software-properties-common \
        sosreport sudo sysvinit-utils tmux tzdata ubuntu-keyring ubuntu-restricted-extras ubuntu-standard \
        udev unzip update-notifier-common vim vim-tiny virtualenv wget whiptail xfsprogs zip zlib1g-dev 
        echo "Packages Installed"
        break
        ;;
    N|n|no) 
        break 
        ;;
    A|a|abort) 
        exit 
        ;;
    *) 
        echo "Unrecognized Answer. Skipping." 
        echo "If you require it. You can re-run the script."
        ;;
esac

echo "======================"
echo "    Install Docker    "
echo "======================"
read -p "Do you wish to install Docker? (Y)es (N)o (A)bort...   " yn2
case $yn2 in
    Y|y|yes) 
        echo "Installing Docker"
        sudo apt update && sudo apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common 
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - 
        sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" 
        sudo apt update && sudo apt install -y docker-ce 
        sudo usermod -aG docker $USER 
        sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose 
        sudo chmod +x /usr/local/bin/docker-compose 
        docker -v 
        echo "Docker Installed. System will reboot now." 
        echo "After Reboot, re-run this script and skip (answer with No) the first two steps (including Docker)" 
        sudo reboot
        break
        ;;
    N|n|no) 
        break
        ;;
    A|a|abort) 
        exit
        ;;
    *) 
        echo "Unrecognized Answer. Skipping."
        echo "If you require it. You can re-run the script."
        ;;
esac

echo "======================"
echo "   Install Node.js    "
echo "======================"
read -p "Do you wish to install Node.js? (Y)es (N)o (A)bort...   " yn3
case $yn3 in
    Y|y|yes) 
        echo "Installing Node.js" 
        curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - 
        sudo apt update && sudo apt install -y nodejs 
        node -v 
        echo "Node.js Installed"
        break
        ;;
    N|n|no) 
        break
        ;;
    A|a|abort) 
        exit
        ;;
    *) 
        echo "Unrecognized Answer. Skipping."
        echo "If you require it. You can re-run the script."
        ;;
esac

echo "======================"
echo "   Install MariaDB    "
echo "======================"
read -p "Do you wish to install MariaDB? (Y)es (N)o (A)bort...   " yn4
case $yn4 in
    Y|y|yes) 
        echo "Installing MariaDB" 
        sudo apt update && sudo apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common 
        sudo apt-key adv --fetch-keys 'https://mariadb.org/mariadb_release_signing_key.asc' 
        sudo add-apt-repository 'deb [arch=amd64] http://mirror.netcologne.de/mariadb/repo/10.5/ubuntu focal main'
        sudo apt update && sudo apt install -y mariadb-server 
        echo "================================" 
        echo " Next Steps Require User Input  " 
        echo "================================" 
        sudo /usr/bin/mysql_secure_installation 
        sudo service mysql start 
        mariadb -V 
        echo "MariaDB Installed"
        break
        ;;
    N|n|no) 
        break
        ;;
    A|a|abort) 
        exit
        ;;
    *) 
        echo "Unrecognized Answer. Skipping."
        echo "If you require it. You can re-run the script."
        ;;
esac

echo "============================="
echo "   Install FFMPEG Non-free   "
echo "============================="
read -p "Do you wish to install FFMPEG? (Y)es (N)o (A)bort...   " yn5
case $yn5 in
    Y|y|yes) 
        echo "Installing Non-free FFMPEG" 
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
        xtrans-dev yasm libxml2 libflite1 libgsm1 libssl-dev 
        mkdir -p ~/ffmpeg_sources ~/bin  
        cd ~/ffmpeg_sources  
        wget -O ffmpeg-4.2.3.tar.bz2 https://ffmpeg.org/releases/ffmpeg-4.2.3.tar.bz2  
        tar xjvf ffmpeg-4.2.3.tar.bz2  
        cd ffmpeg-4.2.3  
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
        --enable-vaapi 
        PATH="/usr/local/bin:$PATH" make -j $(nproc) 
        sudo make install 
        hash -r 
        sudo apt purge -y \
        autoconf automake autotools-dev cmake cmake-data comerr-dev flite1-dev frei0r-plugins-dev \
        ghc gir1.2-freedesktop gir1.2-gdkpixbuf-2.0 gir1.2-harfbuzz-0.0 gir1.2-ibus-1.0 gir1.2-rsvg-2.0 \
        icu-devtools krb5-multidev ladspa-sdk libaom-dev libasound2-dev libass-dev libauthen-sasl-perl \
        libavutil-dev libblkid-dev libbs2b-dev libbsd-dev libcaca-dev libcairo-script-interpreter2 \
        libcairo2-dev libcdio-cdda-dev libcdio-dev libcdio-paranoia-dev libchromaprint-dev libcodec2-dev \
        libcurl4-gnutls-dev libdata-dump-perl libdc1394-25 libdc1394-dev libdrm-dev libegl-dev \
        libegl1-mesa-dev libencode-locale-perl libfcgi-perl libfdk-aac-dev libfile-listing-perl libfont-afm-perl \
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
        xtrans-dev yasm
        sudo apt purge -y ffmpeg && sudo apt autoremove --purge -y && sudo apt autoclean && sudo apt clean 
        sudo rm -R ~/ffmpeg_build/* ~/ffmpeg_sources/* ~/.cache/* 
        ffmpeg -hwaccels 
        echo "FFMPEG Installed"
        break
        ;;
    N|n|no) 
        break
        ;;
    A|a|abort) 
        exit
        ;;
    *) 
        echo "Unrecognized Answer. Skipping."
        echo "If you require it. You can re-run the script."
        ;;
esac

echo "========================"
echo "   Install Pulseaudio   "
echo "========================"
read -p "Do you wish to install Pulseaudio? (Y)es (N)o (A)bort...   " yn6
case $yn6 in
    Y|y|yes) 
        echo "Installing Pulseaudio" 
        sudo apt update && sudo apt install -y apulse avahi-daemon pulseaudio \
        gstreamer1.0-pulseaudio pulseaudio-module-zeroconf pulseaudio-utils 
        sudo mv /etc/pulse/default.pa /etc/pulse/default.old 
        sudo curl -L "https://raw.githubusercontent.com/mssaleh/binaries/master/pulseaudio/default.pa" -o /etc/pulse/default.pa 
        pulseaudio --kill 
        pulseaudio --start 
        sleep 5
        pulseaudio --kill 
        systemctl --user daemon-reload 
        sudo systemctl daemon-reload 
        systemctl --user enable pulseaudio.socket 
        systemctl --user enable pulseaudio.service 
        sudo usermod -aG pulse,pulse-access,audio,bluetooth root 
        sudo usermod -aG pulse,pulse-access,audio,bluetooth $USER 
        systemctl --user restart pulseaudio.socket 
        systemctl --user restart pulseaudio.service 
        systemctl --user status pulseaudio.service 
        echo "Pulseaudio Installed"
        break
        ;;
    N|n|no) 
        break
        ;;
    A|a|abort) 
        exit
        ;;
    *) 
        echo "Unrecognized Answer. Skipping."
        echo "If you require it. You can re-run the script."
        ;;
esac

echo "======================="
echo "   Install Bluetooth   "
echo "======================="
read -p "Do you wish to install Bluetooth? (Y)es (N)o (A)bort...   " yn7
case $yn7 in
    Y|y|yes) 
        echo "Installing Bluetooth" 
        sudo apt update && sudo apt install -y bluetooth bluez bluez-tools bluez-hcidump \
        libbluetooth-dev pulseaudio-module-bluetooth python3-bluez avahi-daemon 
        sudo usermod -aG audio,bluetooth root 
        sudo usermod -aG audio,bluetooth $USER 
        sudo service bluetooth enable 
        sudo service bluetooth restart 
        sudo service bluetooth status 
        echo "Bluetooth Installed"
        break
        ;;
    N|n|no) 
        break
        ;;
    A|a|abort) 
        exit
        ;;
    *) 
        echo "Unrecognized Answer. Skipping."
        echo "If you require it. You can re-run the script."
        ;;
esac

echo "====================="
echo "   Install Aircast   "
echo "====================="
read -p "Do you wish to install Aircast? (Y)es (N)o (A)bort...   " yn8
case $yn8 in
    Y|y|yes) 
        echo "Installing Aircast" 
        sudo curl -L "https://raw.githubusercontent.com/philippe44/AirConnect/master/bin/aircast-x86-64" -o /usr/local/bin/aircast 
        sudo chmod +x /usr/local/bin/aircast 
        sudo curl -L "https://raw.githubusercontent.com/mssaleh/binaries/master/aircast/aircast.service" -o /usr/lib/systemd/user/aircast.service 
        sudo mkdir -p /etc/aircast 
        sudo curl -L "https://raw.githubusercontent.com/mssaleh/binaries/master/aircast/aircast.xml" -o /etc/aircast/aircast.xml 
        systemctl --user daemon-reload 
        sudo systemctl daemon-reload 
        systemctl --user enable aircast.service 
        systemctl --user restart aircast.service 
        sleep 3
        systemctl --user status aircast.service 
        echo "Aircast Installed"
        break
        ;;
    N|n|no) 
        break
        ;;
    A|a|abort) 
        exit
        ;;
    *) 
        echo "Unrecognized Answer. Skipping."
        echo "If you require it. You can re-run the script."
        ;;
esac

echo "============================"
echo "   Install shairport-sync   "
echo "============================"
read -p "Do you wish to install shairport-sync? (Y)es (N)o (A)bort...   " yn9
case $yn9 in
    Y|y|yes) 
        echo "Installing shairport-sync" 
        sudo apt install -y --no-install-recommends \
        autoconf automake autotools-dev avahi-daemon build-essential \
        git libaacs-dev libasound2-dev libauthen-sasl-perl libavahi-client-dev \
        libconfig-dev libconfig-doc libdaemon-dev libdata-dump-perl libfaac0 \
        libfaac-dev libfdk-aac-dev libfile-listing-perl libflac-dev \
        libfont-afm-perl libhtml-format-perl libhtml-form-perl libhtml-tree-perl \
        libhttp-cookies-perl libhttp-daemon-perl libhttp-negotiate-perl \
        libio-socket-ssl-perl libltdl-dev liblwp-protocol-https-perl \
        libmailtools-perl libmbedcrypto3 libmbedtls12 libmbedtls-dev \
        libmbedx509-0 libnet-http-perl libnet-smtp-ssl-perl libogg-dev \
        libpopt-dev libpulse-dev libpulse-mainloop-glib0 libsndfile1-dev \
        libsoxr-dev libsoxr-lsr0 libssl-dev libtool libtry-tiny-perl \
        libvo-aacenc-dev libvorbis-dev libwww-perl \
        libwww-robotrules-perl libxml-parser-perl m4 xmltoman 
        mkdir -p ~/shairport 
        cd ~/shairport  
        git clone "https://github.com/mikebrady/alac.git" 
        cd ~/shairport/alac  
        autoreconf -fi  
        ./configure  
        make  
        sudo make install  
        sudo ldconfig  
        cd ~/shairport  
        git clone "https://github.com/mikebrady/shairport-sync.git"  
        cd ~/shairport/shairport-sync  
        autoreconf -fi  
        ./configure --sysconfdir=/etc --with-alsa --with-pa --with-avahi --with-ssl=openssl --with-metadata --with-soxr --with-libdaemon --with-stdout --with-pipe --with-convolution --with-apple-alac  
        make  
        sudo make install  
        sudo apt purge -y \
        autoconf automake autotools-dev libaacs-dev libasound2-dev \
        libauthen-sasl-perl libblkid-dev libconfig-dev libconfig-doc \
        libdaemon-dev libdata-dump-perl libencode-locale-perl \
        libfaac-dev libfdk-aac-dev libfile-listing-perl libflac-dev \
        libfont-afm-perl libglib2.0-dev libglib2.0-dev-bin \
        libhtml-form-perl libhtml-format-perl libhtml-parser-perl \
        libhtml-tagset-perl libhtml-tree-perl libhttp-cookies-perl \
        libhttp-daemon-perl libhttp-date-perl libhttp-message-perl \
        libhttp-negotiate-perl libio-html-perl libio-socket-ssl-perl \
        libltdl-dev liblwp-mediatypes-perl liblwp-protocol-https-perl \
        libmailtools-perl libmbedcrypto3 libmbedtls-dev libmbedtls12 \
        libmbedx509-0 libmount-dev libnet-http-perl libnet-smtp-ssl-perl \
        libogg-dev libpcre16-3 libpcre2-16-0 libpcre2-32-0 libpcre2-dev \
        libpcre2-posix2 libpcre3-dev libpcre32-3 libpcrecpp0v5 \
        libpopt-dev libpulse-dev libpulse-mainloop-glib0 libselinux1-dev \
        libsepol1-dev libsndfile1-dev libsoxr-dev libssl-dev \
        libtimedate-perl libtool libtry-tiny-perl liburi-perl \
        libvo-aacenc-dev libvorbis-dev libwww-perl libwww-robotrules-perl \
        libxml-parser-perl m4 uuid-dev xmltoman  
        sudo apt install -y --no-install-recommends \
        avahi-daemon libasound2 libavahi-client3 libavahi-common3 \
        libc6 libconfig9 libdaemon0 libgcc-s1 libglib2.0-0 libjack-jackd2-0 \
        libmosquitto1 libpopt0 libpulse0 libsndfile1 libsoxr0 libssl1.1 libstdc++6 
        sudo rm -R ~/shairport ~/.cache/* 
        sudo mv /etc/shairport-sync.conf /etc/shairport-sync.old 
        sudo curl -L "https://raw.githubusercontent.com/mssaleh/binaries/master/shairport-sync/shairport-sync.conf" -o /etc/shairport-sync.conf 
        sudo curl -L "https://raw.githubusercontent.com/mssaleh/binaries/master/shairport-sync/shairport-sync.service" -o /usr/lib/systemd/user/shairport-sync.service 
        systemctl --user daemon-reload 
        sudo systemctl daemon-reload 
        sudo systemctl restart avahi-daemon.service
        sleep 2
        sudo systemctl status avahi-daemon.service
        systemctl --user enable shairport-sync.service 
        systemctl --user restart shairport-sync.service 
        sleep 2
        systemctl --user status shairport-sync.service 
        echo "shairport-sync Installed"
        break
        ;;
    N|n|no) 
        break
        ;;
    A|a|abort) 
        exit
        ;;
    *) 
        echo "Unrecognized Answer. Skipping."
        echo "If you require it. You can re-run the script."
        ;;
esac

echo "====================="
echo "   Install Shinobi   "
echo "====================="
read -p "Do you wish to install Shinobi? (Y)es (N)o (A)bort...   " yn10
case $yn10 in
    Y|y|yes) 
        echo "Installing Shinobi" 
        echo "This is an interactive install. Please follow steps on screen." 
        echo "You must skip all MariaDB Steps. (Answer No)" 
        cd ~ && git clone "https://gitlab.com/Shinobi-Systems/Shinobi.git" Shinobi 
        cd Shinobi 
        chmod +x INSTALL/ubuntu.sh && sudo INSTALL/ubuntu.sh 
        sudo mysql -e "CREATE DATABASE IF NOT EXISTS ccio" 
        read -p "Enter password for Shinobi Database:  " shinobi_db_pw 
        shinobi_db_pw=${shinobi_db_pw:-majesticflame} 
        echo $shinobi_db_pw 
        sudo mysql -e "CREATE USER IF NOT EXISTS 'majesticflame'@'127.0.0.1' IDENTIFIED BY '$shinobi_db_pw'" 
        sudo mysql -e "GRANT ALL PRIVILEGES ON ccio.* TO 'majesticflame'@'127.0.0.1'" 
        sudo mysql -e "FLUSH PRIVILEGES" 
        sudo mysql -e "source sql/framework.sql" 
        node tools/modifyConfiguration.js databaseType=mysql 
        sed -i.old "15s,\"\",\""$shinobi_db_pw"\"," conf.json
        node tools/modifyConfiguration.js databaseType=mysql 
        sudo pm2 restart all
        sleep 2 
        sudo pm2 list all 
        echo "Shinobi Installed"
        break
        ;;
    N|n|no) 
        break
        ;;
    A|a|abort) 
        exit
        ;;
    *) 
        echo "Unrecognized Answer. Skipping."
        echo "If you require it. You can re-run the script."
        ;;
esac

echo "====================="
echo "   Install Mopidy   "
echo "====================="
read -p "Do you wish to install Mopidy? (Y)es (N)o (A)bort...   " yn11
case $yn11 in
    Y|y|yes) 
        echo "Installing Mopidy" 
        wget -q -O - https://apt.mopidy.com/mopidy.gpg | sudo apt-key add - 
        sudo wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/buster.list 
        sudo apt update && sudo apt install -y mopidy mopidy-local mopidy-mpd mopidy-tunein 
        sudo python3 -m pip install Mopidy-MusicBox-Webclient Mopidy-Iris 
        mkdir -p ~/media/music
        mkdir -p ~/media/m3u
        sudo mv /etc/mopidy/mopidy.conf /etc/mopidy/mopidy.old 
        sudo curl -L "https://raw.githubusercontent.com/mssaleh/binaries/master/mopidy/mopidy.conf" -o /etc/mopidy/mopidy.conf 
        sudo sed -i "s,local_path,"$HOME"/media,g" /etc/mopidy/mopidy.conf
        sudo systemctl enable mopidy 
        sudo usermod -aG pulse,pulse-access,audio,bluetooth mopidy 
        sudo systemctl restart mopidy 
        sudo mopidyctl config 
        sudo mopidyctl local scan
        echo "Mopidy Installed"
        break
        ;;
    N|n|no) 
        break
        ;;
    A|a|abort) 
        exit
        ;;
    *) 
        echo "Unrecognized Answer. Skipping."
        echo "If you require it. You can re-run the script."
        ;;
esac

echo "====================================="
echo "   Install HomeAssistant Ecosystem   "
echo "====================================="
read -p "Do you wish to install HomeAssistant Ecosystem? (Y)es (N)o (A)bort...   " yn12
case $yn12 in
    Y|y|yes) 
        echo "Installing HomeAssistant Ecosystem" 
        cd ~ && git clone "https://github.com/mssaleh/binaries.git" 
        cp -r ~/binaries/homeassistant ~/homeassistant
        sudo chown -R $USER: ~/homeassistant && sudo chmod -R +rw ~/homeassistant
        cd ~/homeassistant && docker-compose up -d 
        echo "Running HomeAssistant Core" 
        cp -r ~/binaries/addons ~/addons && sudo chown -R $USER: ~/addons
        sudo chown -R $USER: ~/addons && sudo chmod -R +rw ~/addons
        read -p "Enter your domain name: (e.g. user.smart-home.app):  " domain_name 
        echo "You entered this domain: $domain_name" 
        sed -i "s/domain_name/$domain_name/g" ~/addons/docker-compose.yml 
        sed -i "s/domain_name/$domain_name/g" ~/addons/letsencrypt/config/nginx/site-confs/default 
        sed -i "s/domain_name/$domain_name/g" ~/addons/letsencrypt/config/nginx/proxy-confs/adguard.subdomain.conf 
        sed -i "s/domain_name/$domain_name/g" ~/addons/letsencrypt/config/nginx/proxy-confs/shinobi.subdomain.conf 
        mkdir -p ~/addons/letsencrypt/config/dns-conf 
        read -p "Enter Digital Ocean Access Token:  " digitalocean_token 
        echo "You entered this token: $digitalocean_token" 
        echo "dns_digitalocean_token = $digitalocean_token" > ~/addons/letsencrypt/config/dns-conf/digitalocean.ini 
        chmod 640 ~/addons/letsencrypt/config/dns-conf/digitalocean.ini
        mkdir -p ~/addons/mosquitto/log
        touch ~/addons/mosquitto/log/mosquitto.log
        touch ~/addons/mosquitto/config/mosquitto.passwd
        chmod 640 ~/addons/mosquitto/config/mosquitto.passwd
        cd ~/addons && docker-compose up -d 
        echo "waiting 20s for docker container to run"
        sleep 20
        read -p "Enter Mosquitto MQTT Broker User Name:   " mosquitto_user 
        echo "Mosquitto User Name is: $mosquitto_user" 
        echo "Enter Mosquitto Password for $mosquitto_user" 
        cd ~/addons && docker-compose exec mosquitto mosquitto_passwd -c /mosquitto/config/mosquitto.passwd $mosquitto_user 
        echo "HomeAssistant Ecosystem Installed"
        break
        ;;
    N|n|no) 
        break
        ;;
    A|a|abort) 
        exit
        ;;
    *) 
        echo "Unrecognized Answer. Skipping."
        echo "If you require it. You can re-run the script."
        ;;
esac
