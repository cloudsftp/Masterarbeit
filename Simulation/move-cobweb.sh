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

if [ -n "$COPY_NAME" ]; then
    DIAGRAM_COPY_DIR="${MODEL_DIR}/${COPY_NAME}"
    cp -r "${DIAGRAM_DIR}" "${DIAGRAM_COPY_DIR}"
    DIAGRAM_DIR="${DIAGRAM_COPY_DIR}"
fi
