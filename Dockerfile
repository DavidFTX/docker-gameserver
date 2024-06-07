FROM davidftx/debian-baseimage

LABEL org.opencontainers.image.source="https://github.com/DavidFTX/docker-gameservers"

RUN apt-get update && \
	apt-get -y install --no-install-recommends lib32gcc-s1 && \
	rm -rf /var/lib/apt/lists/*

ENV DATA_DIR="/serverdata"
ENV STEAMCMD_DIR="${DATA_DIR}/steamcmd"
ENV SERVER_DIR="${DATA_DIR}/serverfiles"
ENV GAME_ID="template"
ENV GAME_MODE="template"
ENV GAME_MAX_PLAYERS="template"
ENV GAME_PARAMS_EXTRA="template"
ENV MAP="template"
ENV SERVER_NAME="template"
ENV SRV_PWD=""
ENV SRV_ADMIN_PWD=""
ENV GAME_PORT=8777
ENV QUERY_PORT=27015
ENV VALIDATE=""
ENV UMASK=000
ENV UID=99
ENV GID=100
ENV USERNAME=""
ENV PASSWRD=""
ENV USER="steam"
ENV DATA_PERM=770

RUN mkdir $DATA_DIR && \
	mkdir $STEAMCMD_DIR && \
	mkdir $SERVER_DIR && \
	useradd -d $DATA_DIR -s /bin/bash $USER && \
	chown -R $USER $DATA_DIR

ADD /scripts/ /opt/scripts/
RUN chmod -R 750 /opt/scripts/

#Server Start
ENTRYPOINT ["/opt/scripts/start.sh"]