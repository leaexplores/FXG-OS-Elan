#Ecrit par Mathieu Rheaume <ddrmanxbxfr@gmail.com>
#Mai 2011
#Quebec, Quebec, Canada
#!/bin/bash
DIR=`sh /etc/elan/directory.sh`
case $1 in
#Affiche la description du paquet.
	"desc")
		echo "Version de emacs : 23.3"
		echo "Description : emacs est un editeur de texte de la suite GNU."
		echo "URL : http://www.gnu.org/software/emacs/"
	;;
#Installation du paquet.
	"install")
	if [ ! -f $DIR/sources/emacs-23.3.tar.xz ]
	then
		cd $DIR/sources
		wget 216.24.201.109/packets/emacs-23.3.tar.xz
	fi
#Depaquetage des sources et installation
	echo "Depaquetage des sources"
	tar -xf $DIR/sources/emacs-23.3.tar.xz -C $DIR/cellule
	cd $DIR/cellule/emacs-23.3
	./configure --prefix=/usr/local
	make
	make install
#Ajoute le logiciels a la liste de paquets installes
	echo "emacs-23.3 0" >> $DIR/logiciels_db
	echo "Le $2 a ete installe avec succes"
	;;
#Deinstallation du paquet.
	"uninstall")
	cd $DIR/cellule/emacs*
#Si le dossier n'existe pas!
	if ((`echo $?` != "0"))
	then
		if [ ! -f $DIR/sources/emacs-23.3.tar.xz ]
		then
			cd $DIR/sources
			wget 216.24.201.109/packets/emacs-23.3.tar.xz
		fi
		tar -xf $DIR/sources/emacs-23.3.tar.xz -C $DIR/cellule	
	fi
	make uninstall
	echo "Retire le dossier des sources"
	cd $DIR
	rm -r $DIR/cellule/emacs-23.3
	grep -v "emacs-23.3 0" $DIR/logiciels_db > $DIR/logiciels_db2 && mv logiciels_db2 logiciels_db
	;;
#Repond l'index de version pour l'update.Utiliser pour savoir si le gestionaire de paquet doit updater ou non. 0 pour la premiere release du packet. 1 la 2e 2 la 3e...
	"var_update")
		echo "0"	
	;;
	*)
		echo "Parametre invalide"
	;;
esac
