#Ecrit par Jonathan Roy <jonathanroy20@msn.com>
#Mai 2011
#Quebec, Quebec, Canada
#Installateur pour Elan : Package Menager
#!/bin/bash
directory=`pwd`

echo "======================================="
echo "Installation de Elan : Package Manager"
echo "======================================="

# Demande a l'usager s'il desire enregistrer dans /usr/local/elan ou s'il desire garder l'installation dans son repertoire
while [[ $repdefault != "o" && $repdefault != 'n' ]]
do
	read -p 'Desirez vous installer Elan dans le repertoire defini par default (o ou n) : ' repdefault
done


# Verifie si le dossier elan est deja creer dans /etc
if [ ! -e /etc/elan/ ]
then	
	echo "Creation du repertoire d'elan"
	mkdir /etc/elan/
	
	# Verification de la reponse de l'utilisateur, creation du dossier si selectionner lui par default
	# Changement de la rediriction dans directory.sh, deplacement de directory.sh dans /etc/elan
	if [ $repdefault = 'o' ]
	then
		echo "Enregistrement du repertoire principal"
		echo "echo \"/usr/local/elan/\"" >> directory.sh	
		echo "Creation du repertoire principal"
		mkdir /usr/local/elan/
		echo "Deplacement de la redirection vers le repertoire d'elan"
		mv directory.sh /etc/elan/ 
		echo "Deplacement des fichiers dans le repertoire par default"
		mv * /usr/local/elan/
		echo "Creation des droits sur les fichiers"
		chmod +x /usr/local/elan/elan.sh
		echo "Creation des liens symboliques"
		ln -s /usr/local/elan/elan.sh /usr/local/bin/elan

	else
		echo "Enregistrement du repertoire principal"
		echo "echo \"$directory\"" >> directory.sh
		echo "Deplacement de la redirection vers le repertoire d'elan"
		mv directory.sh /etc/elan/
		echo "Creation des droits sur les fichiers"
		chmod +x `pwd`/elan.sh 
		echo "Creation des liens symboliqes"
		ln -s `pwd`/elan.sh /usr/local/elan
	fi
	
	

else 	
	
	if [ -e /etc/elan/directory.sh ]
	then	
		echo "Suppression de l'ancien fichier directory.sh"
		rm /etc/elan/directory.sh
	fi
	
	echo "Enregistrement du repertoire principal"
	echo "echo \"$directory\"" >> directory.sh

	if [ $repdefault = 'o' ]
	then
		echo "Enregistrement du repertoire principal"
		echo "echo \"/usr/local/elan/\"" >> directory.sh
		echo "Creation du repertoire principal"
		mkdir /usr/local/elan/
		echo "Deplacement de la redirection vers le repertoire d'elan"
		mv directory.sh /etc/elan/
		echo "Deplacement des fichiers vers le repertoire default"
		mv * /usr/local/elan
		echo "Creation des droits sur les fichiers"
		chmod +x usr/local/elan/elan.sh
		echo "Creations des liens symbolique"
		ln -s /usr/local/elan/elan.sh /usr/local/bin/elan

	else
		echo "Enregistrement du repertoire principal"
		echo "echo \"$directory\"" >> directory.sh
		echo "Deplacement de la redirection vers le repertoire d'elan"
		mv directory.sh /etc/elan/
		echo "Creation des droits sur les fichiers"
		chmod +x `pwd`/elan.sh
		echo "Creation des liens symbolique"
		ln -s `pwd`/elan.sh /usr/local/elan
	fi	
   	
fi


echo "===================================="
echo "Installation terminee"
echo "===================================="
