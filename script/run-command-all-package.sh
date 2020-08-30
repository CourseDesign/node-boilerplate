#!/bin/bash

# 파라미터가 없으면 종료
if [ "$#" -lt 1 ]; then
    echo "$# is Illegal number of parameters."
    echo "Usage: $0 [options]"
	exit 1
fi
args=$*

rootPackage=$(pwd)

# 자식 프로젝트 실행
for package in ./package/*; do
  if [ -d "${package}" ]; then
    cd ${package}
    npm ${args}
    cd ${rootPackage}
  fi
done

# 루드 프로젝트 실행
npm ${args}
