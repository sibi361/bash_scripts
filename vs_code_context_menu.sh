#!/bin/bash
 
folder=${NAUTILUS_SCRIPT_SELECTED_URIS/"file://"/""}

# Adding --disable-telemetry fixed long startup delay issue
bash -c "code --disable-telemetry $folder"

