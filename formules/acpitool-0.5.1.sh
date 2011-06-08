# Ecrit par Justin Lavoie <jlavoie1602@gmail.com>
# Mai 2011
# Quebec, Quebec, Canada
#!/bin/bash
DIR=`sh /etc/elan/directory.sh"`
case $1 in
# Affiche la description du paquet.
    "desc")
	echo "Version de acpitool : 0.5.1"
	echo "Description : acpitool est un outil permettant de controller le fonctionnement de different composant matériel."
	echo "URL : http://freeunix.dyndns.org:8088/site2/acpitool.shtml"
	;;
# Installation du paquet.
    "install")
	if [ ! -f $DIR/sources/acpitool-0.5.1.tar.xz ]
	    then
	    cd $DIR/sources
	    wget www.cl.ly/2Y3b2I2I3z1C0C0L350S/acpitool-0.5.1.tar.xz
	    fi

# Depaquetage des sources et installation
	echo "Depaquetage des sources"
	tar -xf $DIR/sources/acpitool-0.5.1.tar.xz -C $DIR/cellule
	cd $DIR/cellule/acpitool-0.5.1
	make install
# Ajoute le logiciel a la liste des paquets installes
	echo "acpitool-0.5.1 0" >> $DIR/logiciels_db
	echo "Le $2 a ete installe avec succes"
	;;

# Desinstallation du paquet.
    "uninstall")
	cd $DIR/cellule/acpitool*
# Si le dossier n'existe pas
	if ((`echo $?` != "0"))
	    then
	    if [ ! -f $DIR/sources/acpitool-0.5.1.tar.xz ] 
	    then
		cd $DIR/sources
		wget www.cl.ly/2Y3b2I2I3z1C0C0L350S/acpitool-0.5.1.tar.xz
		fi
	    tar -xf $DIR/sources/acpitool-0.5.1.tar.xz -C $DIR/cellule
	    fi
	make uninstall
	echo "Retire le dossier des sources"
	cd $DIR
	rm -r $DIR/cellule/acpitool-0.5.1
	grep -v "acpitool-0.5.1 0" $DIR/logiciels_db > $DIR/logiciels_db
	;;
# Repond l'index de version pour l'update. Utiliser pour savoir si le gestionnaire de paquet doit updater ou non. 0 pour la premiere relsea du paquet. 1 la 2e, 2 la 3e...
    "var_update")
	echo "0"
	;;
    *)
	echo "Parametre invalide"
	;;
esac
    