FROM amazonlinux:2

RUN yum -y install curl nano nload top screen git ps wget tar bzip2 gzip unzip zlib zlib.i686 lib32z1 python3 binutils bc jq tmux glibc.i686 libstdc++ libstdc++.i686 \
    shadow-utils util-linux file nmap-ncat iproute SDL2.i686 SDL2.x86_64 sed \
    && yum -y update --security

RUN useradd louis
WORKDIR /home/louis
USER louis

RUN wget http://media.steampowered.com/installer/steamcmd_linux.tar.gz && tar -xzf steamcmd_linux.tar.gz \
    && rm steamcmd_linux.tar.gz && ./steamcmd.sh +quit
RUN mkdir -p .steam/sdk32/ && ln -s ~/linux32/steamclient.so ~/.steam/sdk32/steamclient.so \
    && mkdir -p .steam/sdk64/ && ln -s ~/linux64/steamclient.so ~/.steam/sdk64/steamclient.so
RUN ./steamcmd.sh +login anonymous +force_install_dir ./l4d2 +app_update 222860 +quit
RUN git clone -b zonemod https://github.com/fantasylidong/anne.git zonemod
RUN git clone -b mysql https://github.com/fantasylidong/neko.git
RUN git clone https://github.com/fantasylidong/hardcoop.git
RUN git clone https://github.com/fantasylidong/L4D2-Competitive-Rework.git

EXPOSE 27015/tcp
EXPOSE 27015/udp

ENV PORT=2333 \
    PLAYERS=8 \
    MAP="c2m1_highway" \
    REGION=255 \
    HOSTNAME="leo fighting" \
    plugin="null" \
	steamid="STEAM_1:1:121430603" \
	password="123456" \
	steamgroup="25622692,26419628"

ADD entrypoint.sh entrypoint.sh
ENTRYPOINT ./entrypoint.sh
