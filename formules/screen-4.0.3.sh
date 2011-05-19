# Ecrit par Justin Lavoie <jlavoie1602@gmail.com>
# Mai 2011
# Quebec, Quebec, Canda
#!/bin/bash
DIR=`sh /etc/elan/directory.sh`
case $1 in
# Affiche la description du paquet
    "desc")
	echo "Version de screen : 4.0.3"
	echo "Description : Multiplexeur de terminaux GNU."
	echo "URL : www.gnu.org/software/screen/"
    ;;
# Installation du paquet.
    "install")
    if [ ! -f $DIR/sources/screen-4.0.3.tar.bz2 ]
    then
	cd $DIR/sources
	wget http://cl.ly/1V0e3z141T2U081n2h1M/screen-4.0.3.tar.bz2
    fi
# Depaquetage des sources et installation
    echo "Depaquetage des sources"
    tar -xf $DIR/sources/screen-4.0.3.tar.bz2 -C $DIR/cellule
    cd $DIR/cellule/screen-4.0.3
    make install
# Ajout du logiciiel a la liste des paquets installes
    echo "screen-4.0.3 0" >> $DIR/logiciels_db
    echo "LE $2 a ete installe avec succes"
    ;;
# Desinstallation du paquet.
    "uninstall")
# si le dossier n'existe pas !
    if [ ! -d $DIR/sources/screen-4.0.3 ]
    then
	if [ ! -f $DIR/sources/screen-4.0.3.tar.bz2 ]
	then
	    cd $DIR/sources
	    wget http://cl.ly/1V0e3z141T2U081n2h1M/screen-4.0.3.tar.bz2
	fi
	tar -xf $DIR/sources/screen-4.0.3.tar.bz2 -C $DIR/cellule
    fi
    cd $DIR/cellule/screen-4.0.3
    make uninstall
    echo "Retire le dossier des sources"
    cd $DIR
    rm -r $DIR/cellule/screen-4.0.3
    grep -v "screen-4.0.3 0" $DIR/logiciels_db > $DIR/logiciels_db
    ;;
# Repond a l'index de version pour l'update. utiliser pour savoir si le gestionnaire de paquet doit updater ou non. 0 pour la premiere release du packet. 1 la 2e 2 la 3e...
    "var_update")
	echo "0"
    ;;
    *)
	echo "Parametre invalide"
    ;;
esac
