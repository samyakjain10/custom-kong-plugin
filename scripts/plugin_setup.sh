#!/bin/bash

echo "Starting to Install custom plugins"

cd /usr/local/custom/kong/plugins/hide-token
luarocks make

echo "Done Installing custom plugins"