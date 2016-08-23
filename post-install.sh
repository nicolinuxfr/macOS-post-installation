#!/bin/sh

## README
# /!\ Ce script d'installation est conçu pour mon usage. Ne le lancez pas sans vérifier chaque commande ! /!\
# Crédits :
# - Idée originale : https://jeremy.hu/homebrew-cask-automate-mac-install/
# - https://github.com/ryanmaclean/OSX-Post-Install-Script/
# - https://github.com/snwh/osx-post-install
# - https://github.com/bdougherty/dotfiles/blob/master/osx.sh


## La base : Homebrew et les lignes de commande
echo 'Installation des lignes de commandes'
xcode-select --install

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

echo 'Installation de Cask, pour installer les autres apps.'
brew tap caskroom/cask

## Installations des logiciels
echo 'Installation des outils en ligne de commande.'
brew install wget cmake coreutils psutils git ffmpeg node

echo 'Installation des apps : utilitaires.'
brew cask install alfred sizeup typinator istat-menus dropbox seafile-client flux appcleaner backblaze hosts carbon
# FastScripts
mas install 446994638
# PopClip
mas install 445189367
# Amphetamine
mas install 937984704

# Installation et configuration de ZSH
brew install zsh && \
sudo sh -c 'echo $(brew --prefix)/bin/zsh >> /etc/shells' && \
chsh -s $(brew --prefix)/bin/zsh

echo 'Installation des apps : écriture.'
# iA Writer
mas install 775737590
# Marked
mas install 890031187
brew cask install evernote

echo 'Installation des apps : développement.'
brew install hugo
brew cask install iterm2 github-desktop textmate tower coda atom wordpresscom transmit
# Xcode
mas install 497799835
# Quiver 
mas install 866773894
# JSON Helper for AppleScript
mas install 453114608
# Twitter Scripter
mas install 645249778


echo 'Installation des apps : communication.'
# Reeder
mas install 880001334
# Twitter
mas install 409789998
# Tweetbot
mas install 557168941
# 1Password
mas install 443987910
# Wunderlist
mas install 410628904
brew cask install google-chrome firefox mattermost evernote transmission


echo 'Installation des apps : photo et vidéo.'
brew cask install imageoptim sketch google-photos-backup
# Acorn
mas install 1019272813
# Pixelmator
mas install 407963104
#JPEG Mini
mas install 498944723
# Final Cut Pro
mas install 424389933
# Napkin
mas install 581789185
# Precise Screenshot
mas install 531794281


echo 'Installation des apps : loisir.'
brew install mpv --with-bundle
brew linkapps mpv # Pour avoir un .app dans le dossier des Applications
# TunesArt
mas install 444696268 
brew cask install vox xld beardedspice


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


## ************ Fin de l'installation *********
echo "Finder et Dock relancés… redémarrage nécessaire pour terminer."
killall Dock
killall Finder

echo "Derniers nettoyages…"
brew cleanup
rm -f -r /Library/Caches/Homebrew/*


echo "ET VOILÀ"