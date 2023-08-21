#!/bin/bash

FOLDERS=(symbolic-regions translating-symbolic Report Figures Simulation)

TARGET_DIR="Masterarbeit_Weik_SourceCode"
TARGET_ARCHIVE_PICS="${TARGET_DIR}_WithPictures.tar.gz"
TARGET_ARCHIVE="${TARGET_DIR}.tar.gz"

mkdir -p "${TARGET_DIR}"
for folder in "${FOLDERS[@]}"; do
    cp -r "${folder}" "${TARGET_DIR}"
done

tar cfz "${TARGET_ARCHIVE_PICS}" "${TARGET_DIR}"
du -h "${TARGET_ARCHIVE_PICS}"

cd "${TARGET_DIR}"
find . -name '*.png' | xargs -I{} rm {}
cd - &> /dev/null

tar cfz "${TARGET_ARCHIVE}" "${TARGET_DIR}"
du -h "${TARGET_ARCHIVE}"

rm -rf "${TARGET_DIR}"
