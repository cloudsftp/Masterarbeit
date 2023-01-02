#!/bin/bash

help-msg() {
    echo "Usage: $0 (-m | --model) <MODEL_NAME> (-d | --diagram) <DIAGRAM_NAME> [OPTIONS]"
    echo "Options:"
    echo "      -c | --copy <COPY_NAME>     Specify if a copy should be created of the original cobweb"

    exit 2
}

while [ $# -gt 0 ]; do
    case "$1" in
        -m | --model)
            MODEL_NAME="$2"
            shift
            shift
            ;;
        -d | --diagram)
            DIAGRAM_NAME="$2"
            shift
            shift
            ;;
        -c | --copy)
            COPY_NAME="$2"
            shift
            shift
            ;;
        *)
            help-msg
            ;;
    esac
done

[ -z "$MODEL_NAME" ] && help-msg
[ -z "$DIAGRAM_NAME" ] && help-msg

MODELS_DIR="$(pwd)/Models"
MODEL_DIR="$(find "${MODELS_DIR}" -name "*${MODEL_NAME}")"
[ -z "$MODEL_DIR" ] && echo "Could not find a model w/ name ${MODEL_NAME}" && exit 1
cd "$MODEL_DIR"

DIAGRAM_DIR="${MODEL_DIR}/${DIAGRAM_NAME}"
[ ! -d "$DIAGRAM_DIR" ] && echo "No dir ${DIAGRAM_NAME} in ${MODEL_DIR}" && exit 1

# Load current parameters

declare -A PARAMETER_VALUES
declare -A PARAMETER_LINES

CONFIG_FILE="${DIAGRAM_DIR}/config.ant"
LINE_NUM="0"
PARSING=""
while read -r LINE; do
    LINE_NUM=$((LINE_NUM + 1))

    if [ -z "${PARSING}" ]; then
        [[ "${LINE}" =~ ^parameter"[".+"]" ]] && PARSING="true" 
    else
        if [[ "${LINE}" =~ ^\},?$ ]]; then
            PARSING=""

            PARAMETER_VALUES["${NAME}"]="${VALUE}"
            PARAMETER_LINES["${NAME}"]="${VALUE_LINE}"
        else
            _NAME="$(echo "${LINE}" | grep ^name | sed -r 's/name\s*=\s*"([^"]*)"/\1/')"
            [ -n "$_NAME" ] && NAME="${_NAME}"
            _VALUE="$(echo "${LINE}" | grep ^value | sed -r 's/value\s*=\s*([^,]*)[,$]/\1/')"
            [ -n "$_VALUE" ] && VALUE="${_VALUE}" && VALUE_LINE="${LINE_NUM}"
        fi
    fi
done < "${CONFIG_FILE}"

echo "Parsed ${CONFIG_FILE}..."
echo
for NAME in "${!PARAMETER_VALUES[@]}"; do
    echo -e "${NAME}: \t${PARAMETER_VALUES["${NAME}"]} \t in line ${PARAMETER_LINES["${NAME}"]}"
done
echo


if [ -n "$COPY_NAME" ]; then
    
    # TODO: output what's happening

    DIAGRAM_COPY_DIR="${MODEL_DIR}/${COPY_NAME}"
    cp -r "${DIAGRAM_DIR}" "${DIAGRAM_COPY_DIR}"
    DIAGRAM_DIR="${DIAGRAM_COPY_DIR}"
    CONFIG_FILE="${DIAGRAM_DIR}/config.ant"
fi

# TODO: adjust parameters
