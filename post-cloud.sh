#!/bin/sh

## README
# /!\ Ce script d'installation est conçu pour mon usage. Ne le lancez pas sans vérifier chaque commande ! /!\
# Ce script est à utiliser après la synchronisation des données Dropbox (ou Google Drive, ou iCloud, ou ce que vous voulez)

echo "Installation de mackup et restauration des préférences."
brew install mackup
# Sélection du service de cloud (à commenter si vous utilisez Dropbox, c'est le service par défaut) : https://github.com/lra/mackup/blob/master/doc/README.md
echo -e "[storage]\nengine = google_drive" >> ~/.mackup.cfg

# Récupération de la sauvegarde sans demander à chaque fois l'autorisation
mackup restore -n


echo "Configuration de FastScripts"
defaults write com.red-sweater.FastScripts ScriptTreePathsKey '("~/Google Drive/Logiciels/Scripts")'

echo "Installation de oh-my-zsh"
# Installation de oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
