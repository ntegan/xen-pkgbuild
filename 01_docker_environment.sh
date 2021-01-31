#!/bin/bash

my_dir="$(cd $(dirname $0) && pwd)"

useradd -m ntegan
yes password | passwd ntegan

pacman -Sy
cat >> /etc/sudoers <<EOF 
ntegan ALL=(ALL) NOPASSWD: ALL
EOF
su ntegan --shell /bin/bash -c 'gpg --recv-keys 83FE14C957E82BD9'
