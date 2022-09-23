#!/bin/bash

echo "install and update php things"
composer require "acdh-oeaw/arche-ingest:^1"

ant -f build_arche.xml

vendor/bin/arche-import-metadata html/arche-constants.rdf http://127.0.0.1/api username password --retriesOnConflict 25