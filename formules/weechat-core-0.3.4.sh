#Ecrit par Mathieu Rheaume <ddrmanxbxfr@gmail.com>
#Mai 2011
#Quebec, Quebec, Canada
#!/bin/bash
DIR=`sh /etc/elan/directory.sh`
case $1 in
#Affiche la description du paquet.
	"desc")
		echo "Version de weechat-core : 0.3.4"
		echo "Description : weechat-core est un client IRC. weechat-core est un paquet weechat sans les modules Pyhton Tcl Ruby et autres."
		echo "Dependances : OpenSSH-5.8p2, OpenSSL-1.0.0d(De OpenSSH-5.8p2)"
		echo "URL : http://www.weechat.org"
	;;
#Installation du paquet.
	"install")
	if [ ! -f $DIR/sources/weechat-core-0.3.4.tar.gz ]
	then
		cd $DIR/sources
		wget 216.24.201.109/packets/weechat-core-0.3.4.tar.gz
	fi
#Depaquetage des sources et installation
	echo "Depaquetage des sources"
	tar -xf $DIR/sources/weechat-core-0.3.4.tar.gz -C $DIR/cellule
#Installation des dependances puis de Weechat
	elan install wget-1.12
	elan install openssl-1.0.0d
	elan install openssh-5.8p2
	cd $DIR/cellule/weechat-0.3.4
	make install
#Ajoute le logiciels a la liste de paquets installes
	echo "weechat-core-0.3.4 0" >> $DIR/logiciels_db
	echo "Le $2 a ete installe avec succes"
	;;
	"list-dep")
	echo "wget-1.12"
	echo "openssl-1.0.0d"
	echo "openssh-5.8p2"
	;;
#Deinstallation du paquet.
	"uninstall")
	cd $DIR/cellule/weechat-core*
#Si le dossier n'existe pas!
	if ((`echo $?` != "0"))
	then
		if [ ! -f $DIR/sources/weechat-core-0.3.4.tar.gz ]
		then
			cd $DIR/sources
			wget 216.24.201.109/packets/weechat-core-0.3.4.tar.gz
		fi
		tar -xf $DIR/sources/weechat-core-0.3.4.tar.gz -C $DIR/cellule	
	fi
	cd $DIR/cellule/weechat-*
	make uninstall
	echo "Retire le dossier des sources"
	cd $DIR
	rm -r $DIR/cellule/weechat-0.3.4
	grep -v "weechat-core-0.3.4" $DIR/logiciels_db > $DIR/logiciels_db2 && mv $DIR/logiciels_db2 logiciels_db
	;;
#Repond l'index de version pour l'update.Utiliser pour savoir si le gestionaire de paquet doit updater ou non. 0 pour la premiere release du packet. 1 la 2e 2 la 3e...
	"var_update")
		echo "0"	
	;;
	*)
		echo "Parametre invalide"
	;;
esac
