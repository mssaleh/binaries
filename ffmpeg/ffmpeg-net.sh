                sudo apt purge -y ffmpeg
                sudo apt install -y libavcodec-extra58 libavdevice58 libavfilter-extra7 libavformat58 libavutil56 libc6 \
                libffms2-4 libgpac4 libpostproc55 libsdl2-2.0-0 libstdc++6 libswresample3 libswscale5 libx264-155 libx265-179 x264 x265
                sudo curl -L "https://raw.githubusercontent.com/mssaleh/binaries/master/ffmpeg/ffmpeg" -o /usr/local/bin/ffmpeg
                sudo curl -L "https://raw.githubusercontent.com/mssaleh/binaries/master/ffmpeg/ffplay" -o /usr/local/bin/ffplay
                sudo curl -L "https://raw.githubusercontent.com/mssaleh/binaries/master/ffmpeg/ffprobe" -o /usr/local/bin/ffprobe
                sudo chmod +x /usr/local/bin/ffmpeg
                sudo chmod +x /usr/local/bin/ffplay
                sudo chmod +x /usr/local/bin/ffprobe