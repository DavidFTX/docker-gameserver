# Soulmask dedicated server in a Docker optimized for Unraid
This Docker will download and install SteamCMD and the dedicated server files for the game Soulmask.

**Update Notice:** Simply restart the container if a newer version of the game is available.

## Env params
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. | 3017300 |
| SERVER_NAME | Server Name | Soulmask Docker |
| GAME_MODE | PVE or PVP | pve |
| SRV_PWD | Server Password | secretpassword |
| SRV_ADMIN_PWD | Admin Password | evenmoresecretpassword |
| GAME_PARAMS_EXTRA | Any extra launch parameters | -SILENT |
| GAME_PORT | Game port (UDP) | 8777 |
| QUERY_PORT | Game query port (UDP) | 27015 |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| VALIDATE | Validates the game data | true |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |

## Run example
```
docker run --name Soulmask -d \
	-p 8777:8777/udp -p 27015:27015/udp \
	--env 'GAME_ID=3017300' \
	--env 'SERVER_NAME="Soulmask Hardcore PVP Server' \
	--env 'GAME_MAX_PLAYERS=100' \
	--env 'GAME_MODE=pvp' \
	--env 'SRV_ADMIN_PWD=NoOneWillGuessThis' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/soulmask:/serverdata/serverfiles \
	davidftx/gameserver:soulmask
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from ich777, thank you for your work.
