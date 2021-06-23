#!/bin/bash
#Création d'un groupe

az group create --name tp1-amine --location eastus

#Création  vm

az vm create --resource-group tp1-amine \
  --name amineVM \
  --image UbuntuLTS \
  --generate-ssh-keys \
  --output json \
  --verbose 

sleep 50

#Récupération de l'adresse de la VM

VMIP=$(az vm show -d --name amineVM \
  --resource-group tp1-amine \
  --query 'publicIps' \
  --output tsv)

#Ouverture du port 80

az vm open-port \
    --port 80 \
    --resource-group tp1-amine \
    --name amineVM

chmod +x script-dpl-nodejs.sh

az vm run-command invoke  --command-id RunShellScript --name amineVM -g tp1-amine \
    --scripts @script-nodejs.sh

