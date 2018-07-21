#!/usr/bin/env bash
cp -f services/dalsws.service /etc/systemd/system/
systemctl daemon-reload
ls /etc/systemd/system/
