#!/bin/bash

if [ -z "$1" ]; then
	echo "Package name is undefined!"
	exit 1
else
  echo "Package name is "$1
fi

# 폴더로 이동
cd package

# 폴더 생성
mkdir $1
cd $1

# npm 설정
npm init

# typescript 설정
npm i typescript --save-dev
cp ../../tsconfig.json tsconfig.json

# package.json 수정
filepath=$(pwd)

node ../../script/add-build-scipt-in-package.js "${filepath}/package.json"
node ../../script/change-main-in-package.js "${filepath}/package.json" dist/index.js

# 소스 파일 폴더 생성
mkdir src

# package 설치
cd ../../
npm install ${filepath}
