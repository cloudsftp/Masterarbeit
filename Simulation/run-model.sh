#!/bin/bash

ANT_DIR="$(pwd)/AnT"
ANT_BIN_DIR="${ANT_DIR}/bin"
ANT="${ANT_BIN_DIR}/AnT"
BUILD_SYS="${ANT_BIN_DIR}/build-AnT-system.sh"
ANT_LIB_DIR="${ANT_DIR}/lib64"

LOG_DIR="$(pwd)/Logs"
SCRIPT_DIR="$(pwd)/Scripts"

GENERATE_FUNCTION_DATA="$(pwd)/generate-function-data.py"

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
    echo "Usage: $0 (-m | --model) <MODEL_NAME> (-d | --diagram) <DIAGRAM_NAME> [OPTIONS]"
    echo "Options:"
    echo "    --num-cores           Number of cores to use"
    echo "    --skip-computation    Skip computation, only plot"
    echo "    --simple-figure       Only plot a simplified plot"
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
        --num-cores)
            NUM_CORES="$2"
            shift
            shift
            ;;
        --skip-computation)
            SKIP_COMPUTATION="true"
            shift
            ;;
        --simple-figure)
            SIMPLIFIED_PLOT="true"
            shift
            ;;
        *)
            help_msg
            ;;
    esac
done

[ -z "$MODEL_NAME" ] && help_msg
[ -z "$DIAGRAM_NAME" ] && help_msg

MODELS_DIR="$(pwd)/Models"
MODEL_DIR="$(find "${MODELS_DIR}" -name "*${MODEL_NAME}")"
[ -z "$MODEL_DIR" ] && echo "Could not find a model w/ name ${MODEL_NAME}" && exit 1
cd "$MODEL_DIR"

MODEL_CPP_FILE="$(find "${MODEL_DIR}" -name "*.cpp" -maxdepth 1)"
[ -z "$MODEL_CPP_FILE" ] && echo "No .cpp file in ${MODEL_DIR}" && exit 1

DIAGRAM_DIR="${MODEL_DIR}/${DIAGRAM_NAME}"
[ ! -d "$DIAGRAM_DIR" ] && echo "No dir ${DIAGRAM_NAME} in ${MODEL_DIR}" && exit 1

################
# Compile model
################

PATH="${PATH}:${ANT_BIN_DIR}" "${BUILD_SYS}"

############
# Run model
############

cd "${DIAGRAM_DIR}"

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

if [ -z "$SKIP_COMPUTATION" ]; then
    CONFIG_FILE="${DIAGRAM_DIR}/config.ant"
    POLL_PERIOD="2"

    case "${DIAGRAM_NAME}" in
    Cobweb*)
        ### Standalone mode

        echo
        echo "Starting Ant in standalone mode"

        LD_LIBRARY_PATH="${ANT_LIB_DIR}" "${ANT}" "${MODEL_FILE}" \
            -i "${CONFIG_FILE}" \
            &> "${SERVER_LOG}" &
        
        POLL_PERIOD="0.1"
        ;;
    *)
        ### Server mode

        # Start server

        echo
        echo "Starting AnT server"
        while : ; do
            LD_LIBRARY_PATH="${ANT_LIB_DIR}" "${ANT}" "${MODEL_FILE}" \
                -i "${CONFIG_FILE}" \
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
            echo "Starting AnT client #${i}"
            LD_LIBRARY_PATH="${ANT_LIB_DIR}" "${ANT}" "${MODEL_FILE}" \
                -i "${CONFIG_FILE}" \
                -m client -s "localhost" -p "${PORT}" -t 20 \
                &> "${LOG_DIR}/client-${i}.log" &
        done
        ;;
    esac

    # Wait for computation to finish

    echo
    echo
    while [ "$(tail -n 1 "${SERVER_LOG}")" != "Bye!" ] ; do
        grep % "${SERVER_LOG}" | tail -n 1 | sed 's/%//'
        sleep "${POLL_PERIOD}"
    done
    echo
fi

#######
# Plot
#######

echo
echo "Plotting figure"
echo

RESULT_FIGURE_NAME="result"

case "$(basename ${DIAGRAM_NAME})" in
    *Period*)
        if echo "${DIAGRAM_NAME}" | grep -q "2D"; then
            GNUPLOT_SCRIPT_NAME="2"
        else
            GNUPLOT_SCRIPT_NAME="1"
        fi

        GNUPLOT_SCRIPT_NAME+="D-period"
        
        if echo "${DIAGRAM_NAME}" | grep -q "Diag"; then
            GNUPLOT_SCRIPT_NAME+="-diag"
        fi
        ;;
    *Cobweb*)
        GNUPLOT_SCRIPT_NAME="cobweb"
        CHECK_FOR_DIMENS_FILE_REGARDLESS="true"
        [ ! -f "${MODEL_DIR}/model.plt" ] && [ -f "${MODEL_DIR}/function.py" ] && python "${GENERATE_FUNCTION_DATA}" --model-dir "${MODEL_DIR}" --diagram-name "${DIAGRAM_NAME}"
        [ ! -f "${MODEL_DIR}/model.plt" ] && [ ! -f "${DIAGRAM_DIR}/function.dat" ] && echo "Requires either model.plt in ${MODEL_DIR} or function.dat in ${DIAGRAM_DIR}" && exit 1
        ;;
    *)
        echo "No known gnuplot script for ${DIAGRAM_NAME}"
        exit 1
        ;;
esac

check_for_dimens_file() {
    [ ! -f "dimens.plt" ] && echo "No dimens.plt file in ${DIAGRAM_DIR}" && exit 1
}

if [ -z "$SIMPLIFIED_PLOT" ]; then
    check_for_dimens_file
else
    [ -n "${CHECK_FOR_DIMENS_FILE_REGARDLESS}" ] && check_for_dimens_file

    GNUPLOT_SCRIPT_NAME+="-simple"
    RESULT_FIGURE_NAME+="-simple"
fi

GNUPLOT_SCRIPT="${SCRIPT_DIR}/${GNUPLOT_SCRIPT_NAME}.plt"
RESULT_FIGURE="${RESULT_FIGURE_NAME}.png"

gnuplot -e "script_dir='${SCRIPT_DIR}'; model_dir='${MODEL_DIR}'; diagram_dir='${DIAGRAM_DIR}'" "${GNUPLOT_SCRIPT}"
[ "$?" -ne 0 ] && echo "Problem executing gnuplot script ${GNUPLOT_SCRIPT}" && exit 1

if [ -z "$SIMPLIFIED_PLOT" ]; then
    [ ! -f "${DIAGRAM_DIR}/${RESULT_FIGURE_NAME}_fm" ] && echo "No ${RESULT_NAME}_fm file in ${DIAGRAM_DIR}" && exit 1
    fragmaster

    pdfcrop "${RESULT_FIGURE_NAME}.pdf" "${RESULT_FIGURE_NAME}.pdf"
    convert -rotate 90 -density 600 -alpha off "${RESULT_FIGURE_NAME}.pdf" "${RESULT_FIGURE}"
fi

imv "${RESULT_FIGURE}"
