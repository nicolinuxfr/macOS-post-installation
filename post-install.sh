#!/bin/sh

## README
# /!\ Ce script d'installation est conçu pour mon usage. Ne le lancez pas sans vérifier chaque commande ! /!\
# Crédits :
# - Idée originale : https://jeremy.hu/homebrew-cask-automate-mac-install/
# - https://github.com/ryanmaclean/OSX-Post-Install-Script/
# - https://github.com/snwh/osx-post-install
# - https://github.com/bdougherty/dotfiles/blob/master/osx.sh




## La base : Homebrew et les lignes de commande
if test ! $(which brew)
then
	echo 'Installation de Homebrew'
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Vérifier que tout est bien à jour
brew update

## Utilitaires pour les autres apps : Cask et mas (Mac App Store)
echo 'Installation de mas, pour installer les apps du Mac App Store.'
brew install mas
echo "Saisir le mail du compte iTunes :" 
read COMPTE
echo "Saisir le mot de passe du compte : $COMPTE"
read PASSWORD
mas signin $COMPTE "$PASSWORD"

# Installation d'apps avec mas (source : https://github.com/argon/mas/issues/41#issuecomment-245846651)
function install () {
	# Check if the App is already installed
	mas list | grep -i "$1" > /dev/null

	if [ "$?" == 0 ]; then
		echo "==> $1 est déjà installée"
	else
		echo "==> Installation de $1..."
		mas search "$1" | { read app_ident app_name ; mas install $app_ident ; }
	fi
}

echo 'Installation de Cask, pour installer les autres apps.'
brew tap caskroom/cask

## Installations des logiciels
echo 'Installation des outils en ligne de commande.'
brew install wget cmake coreutils psutils git ffmpeg node libssh
brew tap zyedidia/micro
brew install micro
gem install sass

echo 'Installation des apps : utilitaires.'
brew cask install alfred sizeup typinator istat-menus google-drive seafile-client flux appcleaner backblaze hosts carbon-copy-cloner aerial
install "FastScripts"
install "PopClip"
install "Amphetamine"
install "MacTracker"

echo "Ouverture de Google Drive pour commencer la synchronisation"
open -a Google\ Drive

# Installation manuelle de SearchLink
cd /tmp/ && curl -O http://cdn3.brettterpstra.com/downloads/SearchLink2.2.3.zip && unzip SearchLink2.2.3.zip && cd SearchLink2.2.3 && mv SearchLink.workflow ~/Library/Services/

echo 'Installation des apps : bureautique.'
install "iA Writer"
install "Ulysses"
install "Marked"
install "Pages"
install "Keynote"
install "Numbers"
install "Soulver"
install "Simplenote"
brew cask install evernote

echo 'Installation des apps : développement.'
brew install hugo
brew cask install iterm2 github-desktop textmate tower coda atom wordpresscom transmit
install "Xcode"
install "TextWrangler"
install "Quiver"
install "JSON Helper for AppleScript"
install "Twitter Scripter"


echo 'Installation des apps : communication.'
install "Reeder"
install "Twitter"
install "Tweetbot"
install "1Password"
install "Wunderlist"
brew cask install google-chrome firefox mattermost transmission


echo 'Installation des apps : photo et vidéo.'
brew cask install handbrake handbrakecli imageoptim sketch google-photos-backup qlimagesize
install "Acorn"
install "Pixelmator"
install "JPEG Mini"
install "Napkin"
install "Precise Screenshot"
install "Final Cut Pro"
install "Logic Pro X"
install "Motion"


echo 'Installation des apps : loisir.'
brew install mpv --with-bundle
brew linkapps mpv # Pour avoir un .app dans le dossier des Applications
install "TunesArt"
brew cask install vox xld beardedspice

# DockArt (installation manuelle, faute de mieux)
cd /tmp/ && curl -O http://www.splook.com/Software/DockArt_files/DockArt2.zip && unzip DockArt2.zip && cd DockArt\ 2.2 && mv DockArt.bundle ~/Library/iTunes/iTunes\ Plug-ins


## ************************* CONFIGURATION ********************************
echo "Configuration de quelques paramètres par défaut…"

## DIVERS

# Accès au clavier complet (tabulation dans les boîtes de dialogue)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Arrêt pop-up clavier façon iOS
defaults write -g ApplePressAndHoldEnabled -bool false

# Répétition touches plus rapide
defaults write NSGlobalDomain KeyRepeat -int 0.02

# Alertes sonores quand on modifie le volume
defaults write ~/Library/Preferences/.GlobalPreferences.plist -int 1

# Mot de passe demandé immédiatement quand l'économiseur d'écran s'active
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

## FINDER

# Affichage de la bibliothèque
chflags nohidden ~/Library

# Finder : affichage de la barre latérale / affichage par défaut en mode liste / affichage chemin accès / extensions toujours affichées
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder FXPreferredViewStyle -string “Nlsv”
defaults write com.apple.finder ShowPathbar -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Afficher le dossier maison par défaut
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Recherche dans le dossier en cours par défaut
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Coup d'œîl : sélection de texte
defaults write com.apple.finder QLEnableTextSelection -bool true

# Pas de création de fichiers .DS_STORE
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

## RÉGLAGES DOCK
# Taille du texte au minimum
defaults write com.apple.dock tilesize -int 15
# Agrandissement actif
defaults write com.apple.dock largesize -float 128

## COINS ACTIFS
# En haut à gauche : bureau
defaults write com.apple.dock wvous-tl-corner -int 4
defaults write com.apple.dock wvous-tl-modifier -int 0
# En haut à droite : bureau
defaults write com.apple.dock wvous-tr-corner -int 4
defaults write com.apple.dock wvous-tr-modifier -int 0
# En bas à gauche : fenêtres de l'application
defaults write com.apple.dock wvous-bl-corner -int 3
defaults write com.apple.dock wvous-bl-modifier -int 0
# En bas à droite : Mission Control
defaults write com.apple.dock wvous-br-corner -int 2
defaults write com.apple.dock wvous-br-modifier -int 0


## APPS

# Safari : menu développeur / URL en bas à gauche / URL complète en haut / Do Not Track / 
defaults write com.apple.safari IncludeDevelopMenu -int 1
defaults write com.apple.safari ShowOverlayStatusBar -int 1
defaults write com.apple.safari ShowFullURLInSmartSearchField -int 1
defaults write com.apple.safari SendDoNotTrackHTTPHeader -int 1

# Photos : pas d'affichage pour les iPhone
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool YES


# TextEdit : .txt par défaut
defaults write com.apple.TextEdit RichText -int 0

# Raccourci pour exporter 
defaults write -g NSUserKeyEquivalents '{"Export…"="@$e";"Exporter…"="@$e";}'

## ************ Fin de l'installation *********
echo "Finder et Dock relancés… redémarrage nécessaire pour terminer."
killall Dock
killall Finder

echo "Derniers nettoyages…"
brew cleanup
rm -f -r /Library/Caches/Homebrew/*

echo "ET VOILÀ !"
echo "Après synchronisation des données cloud, lancer le script post-cloud.sh"