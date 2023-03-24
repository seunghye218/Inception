#!/bin/sh

response=$(ps | grep mysqld_safe | wc -l)

if [ "$response" = "2" ]; then
  exit 0
else
  exit 1
fi
