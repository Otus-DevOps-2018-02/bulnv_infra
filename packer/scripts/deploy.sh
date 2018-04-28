#!/bin/sh
cd ~
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
sudo cp ~/puma.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable puma.service
sudo systemctl start puma.service
