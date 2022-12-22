#!/bin/bash

ANT_DIR="$(pwd)/AnT"
ANT_BIN_DIR="${ANT_DIR}/bin"
ANT="${ANT_BIN_DIR}/AnT"
BUILD_SYS="${ANT_BIN_DIR}/build-AnT-system.sh"
ANT_LIB_DIR="${ANT_DIR}/lib64"

LOG_DIR="$(pwd)/Logs"

please_compile_msg() {
    echo "AnT is not correctly installed, please run ./build.sh"
    exit 2
}

[ ! -d "$ANT_DIR" ] && please_compile_msg
[ ! -d "$ANT_BIN_DIR" ] && please_compile_msg
[ ! -d "$ANT_LIB_DIR" ] && please_compile_msg

[ ! -f "$ANT" ] && please_compile_msg
[ ! -f "$BUILD_SYS" ] && please_compile_msg

help_msg() {
    echo "Usage: $0 (-m | --model) <MODEL_NAME> (-c | --config) <CONFIG_NAME> [OPTIONS]"
    echo "Options:"
    echo "    -n | --num-cores      Number of cores to use"
    exit 2
}

while [ $# -gt 0 ]; do
    case "$1" in
        -m | --model)
            MODEL_NAME="$2"
            shift
            shift
            ;;
        -c | --config)
            CONFIG_NAME="$2"
            shift
            shift
            ;;
        -n | --num-cores)
            NUM_CORES="$2"
            shift
            shift
            ;;
        *)
            help_msg
            ;;
    esac
done

[ -z "$MODEL_NAME" ] && help_msg
[ -z "$CONFIG_NAME" ] && help_msg

MODELS_DIR="$(pwd)/Models"
MODEL_DIR="$(find "${MODELS_DIR}" -name "*${MODEL_NAME}")"
[ -z "$MODEL_DIR" ] && echo "Could not find a model w/ name ${MODEL_NAME}" && exit 1
cd "$MODEL_DIR"

MODEL_CPP_FILE="$(find "${MODEL_DIR}" -name "*.cpp")"
[ -z "$MODEL_CPP_FILE" ] && echo "No .cpp file in ${MODEL_DIR}" && exit 1

################
# Compile model
################

"$BUILD_SYS"

############
# Run model
############

MODEL_FILE="${MODEL_CPP_FILE%.*}"
mkdir -p "${LOG_DIR}"
SERVER_LOG="${LOG_DIR}/server.log"
PORT="5555"

# Figure out, how many cores to use

if [ -z "$NUM_CORES" ]; then
    case "$(hostname)" in
        workstation)
            NUM_CORES="12"
            ;;
        openSuseBook)
            NUM_CORES="6"
            ;;
        *)
            echo "No default number of cores known for $(hostname), please specify via option"
            echo
            help_msg
            ;;
    esac
fi

# Start server

echo
echo "Starting server"
while : ; do
    LD_LIBRARY_PATH="${ANT_LIB_DIR}" "${ANT}" "${MODEL_FILE}" \
        -i "${MODEL_DIR}/${CONFIG_NAME}.ant" \
        -m server -s "0.0.0.0" -p "${PORT}" \
        &> "${SERVER_LOG}" &

    sleep 1
    
    [ "$(tail -n 1 "${SERVER_LOG}")" = "Bye!" ] || break
    
    echo -n "."
done
echo success
echo

# Start clients

for (( i=1; i<=NUM_CORES; i++ )); do
    echo "Starting client ${i}"
    LD_LIBRARY_PATH="${ANT_LIB_DIR}" "${ANT}" "${MODEL_FILE}" \
        -i "${MODEL_DIR}/${CONFIG_NAME}.ant" \
        -m client -s "localhost" -p "${PORT}" -t 20 \
        &> "${LOG_DIR}/client-${i}.log" &
done

# Wait for computation to finish

echo
echo
while [ "$(tail -n 1 "${SERVER_LOG}")" != "Bye!" ] ; do
    grep % "${SERVER_LOG}" | tail -n 1 | sed 's/%//'
    sleep 2
done
echo

# Open gnuplot

gnuplot
