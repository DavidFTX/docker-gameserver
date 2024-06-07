#!/bin/bash
if [ ! -f ${STEAMCMD_DIR}/steamcmd.sh ]; then
    echo "SteamCMD not found!"
    wget -q -O ${STEAMCMD_DIR}/steamcmd_linux.tar.gz http://media.steampowered.com/client/steamcmd_linux.tar.gz 
    tar --directory ${STEAMCMD_DIR} -xvzf /serverdata/steamcmd/steamcmd_linux.tar.gz
    rm ${STEAMCMD_DIR}/steamcmd_linux.tar.gz
fi

echo "---Update SteamCMD---"
if [ "${USERNAME}" == "" ]; then
    ${STEAMCMD_DIR}/steamcmd.sh \
    +login anonymous \
    +quit
else
    ${STEAMCMD_DIR}/steamcmd.sh \
    +login ${USERNAME} ${PASSWRD} \
    +quit
fi

echo "---Update Server---"
if [ "${USERNAME}" == "" ]; then
    if [ "${VALIDATE}" == "true" ]; then
    	echo "---Validating installation---"
        ${STEAMCMD_DIR}/steamcmd.sh \
        +force_install_dir ${SERVER_DIR} \
        +login anonymous \
        +app_update ${GAME_ID} validate \
        +quit
    else
        ${STEAMCMD_DIR}/steamcmd.sh \
        +force_install_dir ${SERVER_DIR} \
        +login anonymous \
        +app_update ${GAME_ID} \
        +quit
    fi
else
    if [ "${VALIDATE}" == "true" ]; then
    	echo "---Validating installation---"
        ${STEAMCMD_DIR}/steamcmd.sh \
        +force_install_dir ${SERVER_DIR} \
        +login ${USERNAME} ${PASSWRD} \
        +app_update ${GAME_ID} validate \
        +quit
    else
        ${STEAMCMD_DIR}/steamcmd.sh \
        +force_install_dir ${SERVER_DIR} \
        +login ${USERNAME} ${PASSWRD} \
        +app_update ${GAME_ID} \
        +quit
    fi
fi

echo "---Prepare Server---"
chmod -R ${DATA_PERM} ${DATA_DIR}
echo "---Server ready---"

echo "---Start Server---"
cd ${SERVER_DIR}

if [ -n "$SRV_PWD" ]; then
    ServerPassword="-PSW=${SRV_PWD}"
fi

if [ -n "$SRV_ADMIN_PWD" ]; then
    AdminPassword="-adminpsw=${SRV_ADMIN_PWD}"
fi

if [ -z "$GAME_MODE" ] || ([ "$GAME_MODE" != "pve" ] && [ "$GAME_MODE" != "pvp" ]); then
    echo "ERROR: GAME_MODE must be 'pve' or 'pvp', currently set to: '${GAME_MODE}'"
	sleep 10
    exit 1
fi

set -x

./WSServer.sh Level01_Main -server -SteamServerName="${SERVER_NAME}" -${GAME_MODE} -MaxPlayers=${GAME_MAX_PLAYERS} -backup=900 -saving=600 -log -UTF8Output -MULTIHOME=0.0.0.0 -Port=${GAME_PORT} -QueryPort=${QUERY_PORT} -online=Steam -forcepassthrough ${ServerPassword} ${AdminPassword} ${GAME_PARAMS_EXTRA}