#!/bin/sh

cp /home/seunghye/.env ../../

if [ ! -f "../../../.git" ];
then
    rm  -rf .git .gitignore
fi
