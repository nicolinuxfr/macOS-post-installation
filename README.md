# Script d'installation et de configuration d'un Mac

Ce script me permet d'installer les logiciels que j'utilise et de configurer quelques paramètres automatiquement après l'installation de macOS. 

**⚠️ Ce script a été conçu pour mes besoins. Avant de l'utiliser pensez bien [à le modifier](https://github.com/nicolinuxfr/macOS-post-installation#comment-lutiliser) en fonction de vos besoins ! ⚠️**

## Présentation

Ce script exploite exclusivement des lignes de commande Shell et il n'a ainsi aucune dépendance. Quelques pré-requis toutefois : 

- Il faut être administrateur du Mac pour l'utiliser ;
- pour installer des apps Mac App Store, il faut posséder un compte et saisir ses identifiants au début ;
- les apps à installer depuis la boutique d'Apple doivent déjà être associées à votre compte iTunes Store.


Le script exploite [Homebrew](http://brew.sh "Homebrew — The missing package manager for macOS"), [Cask](https://caskroom.github.io) et [mas](https://github.com/mas-cli/mas) pour installer les apps, [mackup](https://github.com/lra/mackup) pour restaurer des préférences depuis un autre Mac. Plus de nombreuses idées piochées [à droite et à gauche](https://github.com/nicolinuxfr/macOS-post-installation#inspirations).

*Testé avec macOS Sierra et OS X El Capitan.*

## Comment l'utiliser ?

Voici comment utiliser les deux scripts : 

- Téléchargez la dernière version du projet ([lien direct](https://github.com/nicolinuxfr/macOS-post-installation/archive/master.zip)) ;
- ouvrez le fichier `post-install.sh` et modifiez ce qui est installé par défaut : 
	- chaque ligne qui commence par `install` correspond à une app du Mac App Store et vous devez l'avoir achetée au préalable sur votre compte ;
	- chaque ligne qui commence par `brew install` installe des utilitaires en ligne de commande ;
	- chaque ligne qui commence par `brew cask install` installe des applications hors du Mac App Store ;
- pensez à changer la [ligne 65](https://github.com/nicolinuxfr/macOS-post-installation/blob/master/post-install.sh#L65) en fonction du service de Cloud utilisé, ou alors à la supprimer si vous ne voulez pas en utilisez un ;
- à partir de la [ligne 125](https://github.com/nicolinuxfr/macOS-post-installation/blob/master/post-install.sh#L125), le script configure quelques réglages par défaut, à modifier selon vos besoins ;
- ouvrez ensuite le Terminal de macOS, glissez le fichier `post-install.sh` appuyez sur la touche entrée et accrochez votre ceinture ;
- le script demandera les identifiants du compte iTunes Store à utiliser pour le Mac App Store ;
- si tout va bien, il se terminera normalement sans erreur, mais en cas d'erreur, vous devrez relancer le script et réinstaller certaines apps (celles du Mac App Store) ;
- quand le premier script est terminé, synchronisez vos données depuis le cloud et ouvrez le fichier `post-cloud.sh` :
	- [ligne 10](https://github.com/nicolinuxfr/macOS-post-installation/blob/master/post-cloud.sh#L10), modifiez cette ligne en fonction du service de Cloud choisi, ou supprimez la si vous utilisez Dropbox (choix par défaut) ;
- toujours dans le Terminal, glissez le fichier `post-cloud.sh` avant de valider avec la touche entrée pour finir l'installation.


## Inspirations :

Voici quelques scripts qui m'ont servi de base pour créer le mien. Vous y trouverez peut-être des idées pour adapter les scripts en fonction de vos besoins.

- Idée originale : https://jeremy.hu/homebrew-cask-automate-mac-install/
- https://github.com/ryanmaclean/OSX-Post-Install-Script/
- https://github.com/snwh/osx-post-install
- https://github.com/bdougherty/dotfiles/blob/master/osx.sh