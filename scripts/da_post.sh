#!/usr/bin/env bash

if [ "$command" = "/CMD_SUBDOMAIN" ] \
|| [ "$command" = "/CMD_DOMAIN_POINTER" ] \
|| [ "$command" = "/CMD_ACCOUNT_USER" ] \
|| [ "$rewrite_confs" = "./build rewrite_confs" ] \
|| [ "$command" = "/CMD_DOMAIN" ]; then
	if [ -n "$action" ]; then
		/usr/local/da_lsws/scripts/rewrite_confs.sh
	fi
fi
#deletion

if [ "$command" = "/CMD_DOMAIN" ] || [ "$command"="/CMD_SELECT_USERS" ]; then
    if [ "$delete" = "yes" ]; then
        /usr/local/da_lsws/scripts/rewrite_confs.sh
    fi
fi


if [ "$command" = "/CMD_PHP_SAFE_MODE" ]; then
    if [ -n "$action" ]; then
		service litespeed restart
	fi
fi

#printenv >> /usr/local/da_lsws/logs/env.txt
