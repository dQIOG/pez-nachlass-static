#!/bin/bash

# echo "install and update php things"
# composer require "acdh-oeaw/arche-ingest:^1"

# echo "build ARCHE-MD RDFs"
# ant -f build_arche.xml

# echo "ingest ARCHE-CONSTANTS"
# vendor/bin/arche-import-metadata html/arche-constants.rdf http://127.0.0.1/api username password --retriesOnConflict 25

# echo "ingest msdesc resources and facs-cols"
# vendor/bin/arche-import-metadata html/arche.rdf http://127.0.0.1/api username password --retriesOnConflict 25

# echo "ingest facs-res"
# vendor/bin/arche-import-metadata html/arche-facs.rdf http://127.0.0.1/api username password --retriesOnConflict 25

echo "ingest facs-binaries"

vendor/bin/arche-import-binary /mnt/acdh_resources/container/C_pez_19366/R_pez_unidam_export_8768 https://id.acdh.oeaw.ac.at/pez-nachlass http://127.0.0.1/api username password --skip not_exist --flatStructure

vendor/bin/arche-import-binary /mnt/acdh_resources/ARCHE/playground/ https://id.acdh.oeaw.ac.at/pez-nachlass http://127.0.0.1/api username password --skip not_exist --flatStructure