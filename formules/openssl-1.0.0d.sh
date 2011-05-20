# Ecrit par Justin Lavoie <jlavoie1602@gmail.com> et Mathieu Rheaume <ddrmanxbxfr@gmail.com>
# Mai 2011
# Quebec, Quebec, Canada
#!/bin/bash
DIR=`sh /etc/elan/directory.sh`
case $1 in
# Affiche la description du paquet.
	"desc")
		echo "Version de openssl : 1.0.0d"
		echo "Description : Librairie fournissant le support ssl"
		echo "URL : http://www.openssl.org/"
	;;

# Installation du paquet
	"install")
	if [ ! -f $DIR/sources/openssl-1.0.0d.tar.bz2 ]
	then
		cd $DIR/sources
		wget http://cl.ly/2z0r1l3V0W1W0g0X2c1S/openssl-1.0.0d.tar.bz2
	fi
# Depaquetage des sources et installation
	echo "Depaquetage des sources"
	tar -jxvf $DIR/sources/openssl-1.0.0d.tar.bz2 -C $DIR/cellule
	cd $DIR/cellule/openssl-1.0.0d
	make install
# Ajoute le logiciel a la liste des paquets
	echo "openssl-1.0.0d 0" >> $DIR/logiciels_db
	sed -i 's/export PATH=/export PATH=\/usr\/local\/ssl\/bin:/' /etc/profile
	echo "Le $2 a ete intalle avec succes"
	;;
	"uninstall")
	rm -rf /usr/local/ssl
	grep -v "openssl-1.0.0d 0" $DIR/logiciels_db > $DIR/logiciels_db2 && mv logiciels_db2 logiciels_db
	sed -i 's/export PATH=\/usr\/local\/ssl\/bin:/export PATH=/' /etc/profile
	if [ -d $DIR/cellule/openssl-1.0.0d ]
	then
		rm -r $DIR/cellule/openssl-1.0.0d
	fi
	echo "Deinstallation reussie"
	;;
	"var_update")
	echo "0"
	;;
	*)
	echo "Parametre invalide"
	;;
esac
