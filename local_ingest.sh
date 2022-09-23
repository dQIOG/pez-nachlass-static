#!/bin/bash

echo "install and update php things"
composer require "acdh-oeaw/arche-ingest:^1"

echo "build ARCHE-MD RDFs"
ant -f build_arche.xml

echo "ingest ARCHE-CONSTANTS"
vendor/bin/arche-import-metadata html/arche-constants.rdf http://127.0.0.1/api username password --retriesOnConflict 25

echo "ingest resources"

vendor/bin/arche-import-metadata html/arche.rdf http://127.0.0.1/api username password --retriesOnConflict 25
