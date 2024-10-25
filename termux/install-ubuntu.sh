#!/bin/bash
pkg update
pkg upgrade

pkg install proot-distro 
proot-distro install ubuntu
proot-distro login ubuntu
apt-get update && apt-get upgrade 
apt-get install adduser sudo curl vim -y 
# adduser <username>
# EDITOR=vim visudo 
