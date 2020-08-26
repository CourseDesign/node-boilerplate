#!/bin/bash

rootPackage=$(pwd)

#자식 프로젝트 빌드
for package in ./package/*; do
  if [ -d "${package}" ]; then
    echo "Build ${package}"
    cd ${package}
    npm run build
    cd ${rootPackage}
  fi
done

# 루드 프로젝트 빌드
npm run build

