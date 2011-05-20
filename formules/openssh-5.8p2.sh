# Ecrit par Mathieu Rheaume <ddrmanxbxfr@gmail.com>
# Mai 2011
# Quebec, Quebec, Canada
#!/bin/bash
DIR=`sh /etc/elan/directory.sh`
case $1 in
# Affiche la description du paquet.
	"desc")
		echo "Version de openssh : 5.8p2"
		echo "Description : Librairie fournissant le support ssl"
		echo "Dependances : OpenSSL-1.0.0d"
		echo "URL : http://www.openssh.com/portable.html"
	;;
# Installation du paquet
	"install")
# Installation des dependances
	elan install openssl-1.0.0d
	if [ -d /usr/local/ssl ]
	then
	if [ ! -f $DIR/sources/openssh-5.8p2.tar.gz ]
	then
		cd $DIR/sources
		wget 216.24.201.109/packets/openssh-5.8p2.tar.gz
	fi
# Depaquetage des sources et installation
	echo "Depaquetage des sources"
	tar -xf $DIR/sources/openssh-5.8p2.tar.gz -C $DIR/cellule
	cd $DIR/cellule/openssh-5.8p2
	make install
# Ajoute le logiciel a la liste des paquets
	echo "openssh-5.8p2 0" >> $DIR/logiciels_db
	sed -i 's/export PATH=/export PATH=\/usr\/local\/openSSH\/bin:\/usr\/local\/openSSH\/sbin:/' /etc/profile
	echo "Le $2 a ete intalle avec succes"
	else
		echo "L'installation de la dependance OpenSSL-1.0.0d a echoue."
	fi
	;;
	"list-dep")
	echo "openssl-1.0.0d"
	;;
	"uninstall")
	echo "Deinstallation de openssh-5.8p2"
	rm -rvf /usr/local/openSSH
	rm -rvf /etc/ssh
	grep -v "openssh-5.8p2 0" $DIR/logiciels_db > $DIR/logiciels_db2 && mv logiciels_db2 logiciels_db
	if [ -d $DIR/cellule/openssh-5.8p2 ]
	then
		rm -r $DIR/cellule/openssh-5.8p2
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
