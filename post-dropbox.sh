#!/bin/sh

## README
# /!\ Ce script d'installation est conçu pour mon usage. Ne le lancez pas sans vérifier chaque commande ! /!\
# Ce script est à utiliser après la synchronisation des données Dropbox

echo "Installation de mackup et restauration des préférences."
brew install mackup
# Restore sans demander à chaque fois l'autorisation
mackup restore -n

echo "Configuration de FastScripts"
defaults write com.red-sweater.FastScripts ScriptTreePathsKey '("~/Dropbox/Logiciels/Scripts")'

