#!/bin/bash

if [ -z "$1" ]; then
	echo "Script is undefined!"
	exit 1
fi

rootPackage=$(pwd)

#자식 프로젝트 실행
for package in ./package/*; do
  if [ -d "${package}" ]; then
    cd ${package}
    npm run $1
    cd ${rootPackage}
  fi
done

# 루드 프로젝트 실행
npm run $1
