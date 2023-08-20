#!/bin/bash

TARGET_DIR="Masterarbeit_Weik_SourceCode"
TARGET_ARCHIVE="${TARGET_DIR}.tar.gz"

cp -r symbolic-regions "${TARGET_DIR}"
cp -r translating-symbolic "${TARGET_DIR}"

cp -r Simulation "${TARGET_DIR}"
cd "${TARGET_DIR}/Simulation"
find . -name '*.png'

tar cfz "${TARGET_ARCHIVE}" "${TARGET_DIR}"
du -h "${TARGET_ARCHIVE}"
