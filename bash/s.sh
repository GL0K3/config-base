#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <command> <short_name>"
    exit 1
fi

COMMAND=$1
SHORT_NAME=$2

# Define the mapping of short names to arguments
declare -A ARGUMENTS_MAP
ARGUMENTS_MAP["dwh"]="-i ~/.ssh/remote/id_rsa_b1 akovalenko@dwh-portal.ru"
ARGUMENTS_MAP["onsup_ru"]="-i ~/.ssh/remote/id_rsa artk@185.130.214.193"
ARGUMENTS_MAP["onsup_nl"]="-i ~/.ssh/remote/id_rsa artk@146.0.74.110"
ARGUMENTS_MAP["p"]="get pods"

# Define the mapping of short names to allowed commands
declare -A ALLOWED_COMMANDS
ALLOWED_COMMANDS["dwh"]="ssh"
ALLOWED_COMMANDS["onsup_ru"]="ssh"
ALLOWED_COMMANDS["onsup_nl"]="ssh"

ALLOWED_COMMANDS["p"]="kubectl kube k"

# Get the arguments corresponding to the short name
ARGS=${ARGUMENTS_MAP[$SHORT_NAME]}

# Check if the short name exists in the map
if [ -z "$ARGS" ]; then
    echo "Error: No arguments found for short name '$SHORT_NAME'"
    exit 1
fi

# Check if the command is allowed for the given short name
ALLOWED=${ALLOWED_COMMANDS[$SHORT_NAME]}
if [[ ! " $ALLOWED " =~ " $COMMAND " ]]; then
    echo "Error: '$SHORT_NAME' can only be used with the following commands: $ALLOWED"
    exit 1
fi

# Execute the command with the arguments
eval "$COMMAND $ARGS"
