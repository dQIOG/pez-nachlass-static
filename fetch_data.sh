#!/bin/bash

echo "remove potential artefacts from previous runs"
rm -rf pez-editions-legacy-master
rm master.zip
rm -rf ./data/editions

echo "download data from source repo" 
wget d --header="Authorization: token ${MY_GITHUB_TOKEN}" https://github.com/dQIOG/pez-editions-legacy/archive/refs/heads/master.zip

echo "unzip"
unzip master.zip
rm master.zip


echo "move files to data"
python copy_files.py

echo "clean up"
rm -rf pez-editions-legacy-master
