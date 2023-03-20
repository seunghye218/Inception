#!/bin/sh

response=$(ps | grep "master process" | wc -l)

if [ "$response" = "2" ]; then
  exit 0
else
  exit 1
fi
