#!/bin/bash
# pip install
echo "installing python required modules"
pip install -r ./requirements.txt
# set BIG-IP password
echo "Setting BIG-IP Password to $BIGPASS"
ssh admin@bigip.example.com modify auth user admin password $BIGPASS
echo "Provisioning ASM on BIG-IP"
ssh admin@bigip.example.com modify sys provision asm level nominal
echo "Saving BIG-IP config"
ssh admin@bigip.example.com  save sys config