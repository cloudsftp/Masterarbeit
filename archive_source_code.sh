#!/bin/bash

OBJECTS=(\
    README.md \
    symbolic-regions \
    translating-symbolic \
    abstract.txt \
    zusammenfassung.txt \
    Report \
    Figures \
    Simulation \
)

TARGET_DIR="Masterarbeit_Weik_SourceCode"
TARGET_ARCHIVE_PICS="${TARGET_DIR}_WithPictures.tar.gz"
TARGET_ARCHIVE="${TARGET_DIR}.tar.gz"

mkdir -p "${TARGET_DIR}"
for object in "${OBJECTS[@]}"; do
    cp -r "${object}" "${TARGET_DIR}"
done

tar cfz "${TARGET_ARCHIVE_PICS}" "${TARGET_DIR}"
du -h "${TARGET_ARCHIVE_PICS}"

cd "${TARGET_DIR}"
find . -name '*.png' | xargs -I{} rm {}
cd - &> /dev/null

tar cfz "${TARGET_ARCHIVE}" "${TARGET_DIR}"
du -h "${TARGET_ARCHIVE}"

rm -rf "${TARGET_DIR}"
