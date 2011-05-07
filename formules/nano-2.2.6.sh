#Ecrit par Mathieu Rheaume <ddrmanxbxfr@gmail.com>
#Mai 2011
#Quebec, Quebec, Canada
#!/bin/bash
DIR=`sh /etc/elan/directory.sh`
case $1 in
#Affiche la description du paquet.
	"desc")
		echo "Version de nano : 2.2.6"
		echo "Description : nano est un editeur de texte de la suite GNU."
		echo "URL : http://www.nano-editor.org"
	;;
#Installation du paquet.
	"install")
	if [ ! -f $DIR/sources/nano-2.2.6.tar.gz ]
	then
		cd $DIR/sources
		wget http://cl.ly/6YIY/nano-2.2.6.tar.gz
	fi
#Depaquetage des sources et installation
	echo "Depaquetage des sources"
	tar -xf $DIR/sources/nano-2.2.6.tar.gz -C $DIR/cellule
	cd $DIR/cellule/nano-2.2.6
	make install
#Ajoute le logiciels a la liste de paquets installes
	echo "nano-2.2.6 0" >> $DIR/logiciels_db
	echo "Le $2 a ete installe avec succes"
	;;
#Deinstallation du paquet.
	"uninstall")
	cd $DIR/cellule/nano*
#Si le dossier n'existe pas!
	if ((`echo $?` != "0"))
	then
		if [ ! -f $DIR/sources/nano-2.2.6.tar.bz2 ]
		then
			cd $DIR/sources
			wget http://cl.ly/6YIY/nano-2.2.6.tar.gz
		fi
		tar -xf $DIR/sources/nano-2.2.6.tar.bz2 -C $DIR/cellule	
	fi
	make uninstall
	echo "Retire le dossier des sources"
	cd $DIR
	rm -r $DIR/cellule/nano-2.2.6
	grep -v "nano-2.2.6 0" $DIR/logiciels_db > $DIR/logiciels_db
	;;
#Repond l'index de version pour l'update.Utiliser pour savoir si le gestionaire de paquet doit updater ou non. 0 pour la premiere release du packet. 1 la 2e 2 la 3e...
	"var_update")
		echo "0"	
	;;
	*)
		echo "Parametre invalide"
	;;
esac
