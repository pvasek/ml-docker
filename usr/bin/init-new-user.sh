#!/bin/bash
useradd --groups sudo --create-home --shell /bin/bash $1
cp -a /home/.user/. /home/$1/
chown 770 $1 /home/$1
echo 'export PATH="/opt/conda/bin:$PATH"' | tee -a /home/$1/.bashrc

passwd $1
