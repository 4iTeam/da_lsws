#!/usr/bin/env bash

/usr/local/da_lsws/bin/dalsws build
/usr/local/da_lsws/scripts/create_htaccess.sh
service litespeed restart