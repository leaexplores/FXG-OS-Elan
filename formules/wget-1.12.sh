# Ecrit par Justin Lavoie <jlavoie1602@gmail.com>
# Mai 2011
# Quebec, Quebec, Canada
#!/bin/bash
DIR=`sh /etc/elan/directory.sh`
case $1 in
# Affiche la description du paquet.
	"desc")
		echo "Version de wget : 1.12"
		echo "Description : Wget est l'utilitaire de telechargement GNU."
		echo "URL : http://www.gnu.org/software/wget/"
	;;
# Installation du paquet
	"install")
		if [ ! -f $DIR/sources/wget-1.12.tar.bz2 ]
		then
			cd $DIR/sources
			wget http://cl.ly/000F1I0q0b3v0N3W3H1C/wget-1.12.tar.bz2
		fi
# Depaquetage des sources et installation
		echo "Depaquetage des sources"
		tar -jxvf $DIR/sources/wget-1.12.tar.bz2 -C $DIR/cellule
		cd $DIR/cellule/wget-1.12
		make install
# Ajout du logiciel a la liste des paquets installes
		echo "wget-1.12 0" >> $DIR/logiciels_db
		echo "Le $2 a ete installe avec succes"
	;;
# Desinstallation du paquet
	"uninstall")
		cd $DIR/cellule/wget*
# Si le dossier n'existe pas
		if ((`echo $?` != "0"))
		then
			if [ ! -f $DIR/sources/wget-1.12.tar.bz2 ]
			then
				cd $DIR/sources
				
				wget http://cl.ly/000F1I0q0b3v0N3W3H1C/wget-1.12.tar.bz2
			fi
			tar -jxvf $DIR/sources/wget-1.12.tar.bz2 -C $DIR/cellule
		fi
		make uninstall
		echo "Retire le dossier des sources"
		cd $DIR
		rm -r $DIR/cellule/wget-1.12
		grep -v "wget-1.12 0" $DIR/logiciels_db > $DIR/logiciels_db
	;;
# Repond l'index de version l'update. Utiliser pour savoir si le gestionnaire de paquet doit update ou non. 0 pour la premiere release du paquet. 1 la 2e, 2 la 3e...
	"var_update")
		echo "0"
	;;
	*)
		echo "Parametre invalide"
	;;
esac
