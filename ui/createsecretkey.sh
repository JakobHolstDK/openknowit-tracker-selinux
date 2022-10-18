#!/usr/bin/env bash

python3 -m venv /tmp/tmpenv
source /tmp/tmpenv/bin/activate

pip install --upgrade pip
pip install django

python3 -c 'from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())'
vault kv 
rm -r /tmp/tmpenv