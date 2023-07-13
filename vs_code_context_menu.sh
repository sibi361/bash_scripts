#!/bin/bash
 
folder=${NAUTILUS_SCRIPT_SELECTED_URIS/"file://"/""}

bash -c "code $folder"

