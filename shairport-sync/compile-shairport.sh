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
    libwww-robotrules-perl libxml-parser-perl m4 xmltoman && \
    \
    mkdir -p ~/shairport && \
    cd ~/shairport && \
    git clone https://github.com/mikebrady/alac.git && \
    cd ~/shairport/alac && \
    autoreconf -fi && \
    ./configure && \
    make && \
    sudo make install && \
    sudo ldconfig && \
    \
    cd ~/shairport && \
    git clone https://github.com/mikebrady/shairport-sync.git && \
    cd ~/shairport/shairport-sync && \
    autoreconf -fi && \
    ./configure --sysconfdir=/etc --with-alsa --with-pa --with-avahi --with-ssl=openssl --with-metadata --with-soxr --with-libdaemon --with-stdout --with-pipe --with-convolution --with-apple-alac && \
    make && \
    sudo make install && \
    \
    sudo apt-get purge -y \
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
    libxml-parser-perl m4 uuid-dev xmltoman && \
    \
    sudo apt-get install -y --no-install-recommends \
    avahi-daemon libasound2 libavahi-client3 libavahi-common3 \
    libc6 libconfig9 libdaemon0 libgcc-s1 libglib2.0-0 libjack-jackd2-0 \
    libmosquitto1 libpopt0 libpulse0 libsndfile1 libsoxr0 libssl1.1 libstdc++6

