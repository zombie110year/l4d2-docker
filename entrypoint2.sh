#!/bin/bash
# Update Game
./steamcmd.sh +login anonymous +force_install_dir ./l4d2 +app_update 222860 +quit

#Softlink l4d2 maps to addons folder
#It would more convenience while you want add custom map. Exspecially when you have sourcemod plugins
#you just need mount your extra map folder to docker container /map . 
ln  -s  /map/*  l4d2/left4dead2/addons/
ln  -s  /map2/*  l4d2/left4dead2/addons/
# plugins Config
if [ ! -d "/home/louis/l4d2/left4dead2/addons/sourcemod/" ];
then
	if [ "$plugin" = "anne" ];
	then
		cp  -r /home/louis/anne/* l4d2/
		echo "anne plugins packge installed"
		#cloud server settings
		sed -i 's/nb_update_frequency\ 0.014/nb_update_frequency\ 0.03/' /home/louis/l4d2/left4dead2/cfg/networkconfig.cfg
		sed -i 's/fps_max\ 150/fps_max\ 0/' /home/louis/l4d2/left4dead2/cfg/server.cfg
		sed -i '47 s/\"2\"/\"16\"/' /home/louis/l4d2/left4dead2/addons/sourcemod/configs/sourcebans/sourcebans.cfg
		cp /home/louis/l4d2/left4dead2/addons/hostname.txt /home/louis/l4d2/left4dead2/addons/sourcemod/configs/hostname/
		cp /home/louis/l4d2/left4dead2/addons/advertisements.txt /home/louis/l4d2/left4dead2/addons/sourcemod/configs/advertisements.txt
		cp /home/louis/l4d2/left4dead2/addons/sourcemod/plugins/disabled/specrates.smx /home/louis/l4d2/left4dead2/addons/sourcemod/plugins/optional/ 
	fi

	if [ "$plugin" = "angel" ];
	then
		cp  -r /home/louis/AngelBeats/* l4d2/left4dead2/
		echo "AngelBeats plugins packge installed"
	fi

	if [ "$plugin" = "purecoop" ];
	then
		cp  -r /home/louis/purecoop/* l4d2/left4dead2/
		echo "purecoop plugins packge installed"
	fi


	if [ "$plugin" = "neko" ];
	then
		cp  -r /home/louis/neko/* l4d2/left4dead2/
		echo "neko plugins packge installed"
	fi
	
	if [ "$plugin" = "annetv" ];
	then
		cp  -r /home/louis/annetv/* l4d2/
		echo "annetv plugins packge installed"
	fi
	
	if [ "$plugin" = "zone" ];
	then
		cp  -r /home/louis/L4D2-Competitive-Rework/* l4d2/left4dead2/
		echo "zone plugins packge installed"
	fi
	
	if [ "$plugin" = "pureversus" ];
	then
		cp  -r /home/louis/100tickPureVersus/* l4d2/left4dead2/
		echo "pure versus packge installed"
	fi
	
	#plugins admin setting
	echo "sv_region \"$REGION\"" >> /home/louis/l4d2/left4dead2/cfg/server.cfg
	echo "\"$steamid\" \"100:z\"" >> /home/louis/l4d2/left4dead2/addons/sourcemod/configs/admins_simple.ini
	echo "sv_steamgroup \"$steamgroup\"" >> /home/louis/l4d2/left4dead2/cfg/server.cfg
	echo "rcon_password \"$password\"" >> /home/louis/l4d2/left4dead2/cfg/server.cfg
fi

# Start Game
cd l4d2 && ./srcds_run -console -game left4dead2 -ip 0.0.0.0 -tickrate 100 -port "$PORT"  +maxplayers "$PLAYERS" +map "$MAP"