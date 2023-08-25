#!/bin/bash

OBJECTS=( \
    Report/Masterarbeit_Weik.pdf \
    Report/abstract.txt \
    Report/zusammenfassung.txt \
    Masterarbeit_Weik_SourceCode.tar.gz \
)

TARGET_DIR="Masterarbeit_Weik_Submission"
TARGET_ARCHIVE="${TARGET_DIR}.tar.gz"

mkdir -p "${TARGET_DIR}"
for object in "${OBJECTS[@]}"; do
    cp -r "${object}" "${TARGET_DIR}"
done

env GZIP=-9 tar cfz "${TARGET_ARCHIVE}" "${TARGET_DIR}"
du -h "${TARGET_ARCHIVE}"

rm -rf "${TARGET_DIR}"
