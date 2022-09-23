#!/bin/bash

echo "install and update php things"
composer require "acdh-oeaw/arche-ingest:^1"

vendor/bin/arche-delete-resource https://id.acdh.oeaw.ac.at/pez-nachlass  http://127.0.0.1/api username password --recursively
# vendor/bin/arche-delete-resource https://id.acdh.oeaw.ac.at/pez-ms-desc  http://127.0.0.1/api username password --recursively

