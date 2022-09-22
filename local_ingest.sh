#!/bin/bash

echo "install and update php things"
composer require "acdh-oeaw/arche-ingest:^1"

vendor/bin/arche-import-metadata html/arche.rdf http://127.0.0.1/api username password --retriesOnConflict 25