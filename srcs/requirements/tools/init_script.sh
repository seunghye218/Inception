#!/bin/sh

cp /home/seunghye/.env ./srcs/

if [ ! -f "../../../.git" ];
then
    rm  -rf .git .gitignore
fi
