#Ecrit par Mathieu Rheaume <ddrmanxbxfr@gmail.com>
#Mai 2011
#Quebec, Quebec, Canada
#!/bin/bash
DIR=`sh /etc/elan/directory.sh`
case $1 in
#Affiche la description du paquet.
	"desc")
		echo "Version de dhcpcd : 5.2.9"
		echo "Description : Dhcpcd est un client DHCP pour permettre l'acces a l'internet grace a l'attribution d'IP dynamiques."
		echo "URL : http://developer.berlios.de/projects/dhcpcd/"
	;;
#Installation du paquet.
	"install")
	if [ ! -f $DIR/sources/dhcpcd-5.2.9.tar.gz ]
	then
		cd $DIR/sources
		wget http://cl.ly/6Y40/dhcpcd-5.2.9.tar.gz
	fi
#Depaquetage des sources et installation
	echo "Depaquetage des sources"
	tar -xf $DIR/sources/dhcpcd-5.2.9.tar.gz -C $DIR/cellule
	cd $DIR/cellule/dhcpcd-5.2.9
	make install
#Ajoute le logiciels a la liste de paquets installes
	echo "dhcpcd-5.2.9 0" >> $DIR/logiciels_db
	echo "Le $2 a ete installe avec succes"
	;;
#Deinstallation du paquet.
	"uninstall")
	echo "Tentative d'arret de dhcpcd."
	killall dhcpcd	
#Si le dossier n'existe pas!
	if [ -d $DIR/cellule/dhcpcd-5.2.9 ]
	then
	rm -r $DIR/cellule/dhcpcd-5.2.9
	fi
	rm -rv /var/db/dhcpcd-eth*
	rm -rv /run/dhcpcd*
	rm -v /usr/local/libexec/dhcpcd-run-hooks
	rm -rv /usr/local/libexec/dhcpcd-hooks
	rm -v /usr/local/sbin/dhcpcd
	rm -v /usr/local/etc/dhcpcd.conf
	rm -v /usr/local/share/man/man8/dhcpcd-run-hooks.8
	rm -v /usr/local/share/man/man8/dhcpcd.8
	rm -v /usr/local/share/man/man5/dhcpcd.conf.5	
	echo "Retire le dossier des sources"
	grep -v "dhcpcd-5.2.9 0" $DIR/logiciels_db > $DIR/logiciels_db
	;;
#Repond l'index de version pour l'update.Utiliser pour savoir si le gestionaire de paquet doit updater ou non. 0 pour la premiere release du packet. 1 la 2e 2 la 3e...
	"var_update")
		echo "0"	
	;;
	*)
		echo "Parametre invalide"
	;;
esac
