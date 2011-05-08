# Elan Gestionaire de paquet.
# Realise par Mathieu Rheaume <ddrmanxbxfr@gmail.com>
# Location : Quebec, Quebec, Canada
# Mai 2011
#!/bin/bash

# Va chercher le repertoire ou elan est installe grace au script.
# Allez le modifier au besoin.
DIR=`sh /etc/elan/directory.sh`
case $1 in
#Fonction pour faire afficher la description.
	"description")
	$DIR/formules/$2.sh desc
	if ((`echo $?` != "0"))
	then
		clear
		echo "============================================================================"
		echo "*ATTENTION*Il y a eu un probleme lors de la lecture des formules.*ATTENTION*" 
		echo "Soit que le fichier n'existe pas ou qu'il y a une erreure de permission."
		echo "Vous pouvez reparer les permissions avec la commande \"elan fix-perms\""
		echo "============================================================================"
	fi
	;;
#Fonction pour installer le packet.
	"install")
#Verifie si le paquet existe sinon affiche un message.
		ls $DIR/formules/$2.sh 1>/dev/null 2>/dev/null
		if [ "`echo $?`" = 0 ]
		then
#Recherche si le packet est dans la base de donnees des installes
#Variable RECHERCHE pour verifier si le fichier existe et la version a l'interieur de la db.
		RECHERCHE=`cat $DIR/logiciels_db | grep "$2" | awk '{print $1}'`
		if [ "$RECHERCHE" != "" ]
		then
			echo "Le paquet $2 est deja present sur le systeme."
			RECHERCHE=`cat $DIR/logiciels_db | grep "$2" | awk '{print $2}'`
			if [ "$RECHERCHE" = "`$DIR/formules/$2.sh var_update`" ]
			then
				echo "Le paquet $2 est a jour!"
			else
				echo "Mise a jour du paquet $2"
				$DIR/formules/$2 uninstall
				$DIR/formules/$2 install
			fi
	
		else
#Cree un dossier reserve au depacktage du packet.
				echo "Installation de $2"
				$DIR/formules/$2.sh install
				echo "Installation reussi!"
		fi
		else
			echo "Le paquet $2 n'existe pas!"	
#Verification si la recherche trouvera un quelque chose
			ls $DIR/formules/$2* 1>/dev/null 2>/dev/null
			if [ "`echo $?`" = 0 ]
			then
			echo "Vous pourriez installer :"
#Affichage d'une recherche avec le nom du paquet				
			for i in $( ls $DIR/formules/$2* ); do
			echo ""
			sh $i desc
			done
			fi
		fi
	;;
#Fonction pour desinstaller le packet.
	"uninstall")
		RECHERCHE_DEL=`cat $DIR/logiciels_db | grep "$2" | awk '{print $1}'`
		if [ "$RECHERCHE_DEL" != "" ]
		then
			echo "Debut de la deinstallation de $2."
			$DIR/formules/$2.sh uninstall
			echo "Deinstallation termine"
		else
			echo "Le paquet n'est pas present sur le systeme"
		fi
	;;
	"search")
	#Test si il trouve des paquets avant de rentrer dans la boucle
	ls $DIR/formules/$2* 1>/dev/null 2>/dev/null
	if [ "`echo $?`" = 0 ]
	then
		echo "Les resultat de la recherche sont"
		for i in $( ls $DIR/formules/$2* ); do
			echo ""
			sh $i desc
		done
		echo ""
	else
		echo "Aucun paquet trouve"
	fi
	;;
#Fonction qui permet de reparer les permissions des formules.
	"fix-perms")
	echo "Reparation des permissions des formules en cours."
	chmod u+x * $DIR/formules/*.sh
	echo "Les permissions ont ete repare avec succes"
	;;
#Affichage du menu pour l'utilisation.
	*)
	echo "Utilisation de elan."
	echo "============================"
	echo "elan [option] nom_du_package"
	echo "Options possible : uninstall, install, description, search, fix-perms"
	;;
esac
