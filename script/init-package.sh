#!/bin/bash

if [ -z "$1" ]; then
	echo "Package name is undefined!"
	exit 1
else
  echo "Package name is "$1
fi

rootPackage=$(pwd)

# 폴더로 이동
cd package

# 폴더 생성
mkdir $1
cd $1

package=$(pwd)

# npm 설정
npm init

# typescript 설정
npm i typescript --save-dev
npm i @types/node --save-dev

ln -s ../../tsconfig.json tsconfig.json

node ../../script/change-main-in-package.js "${package}/package.json" dist/index.js

# gulp 설정
npm install gulp --save-dev
npm install gulp-typescript --save-dev

ln -s ../../gulpfile.js gulpfile.js

node ../../script/add-scipt-in-package.js "${package}/package.json" build gulp

# 소스 파일 폴더 생성
mkdir src

# package 설치
cd ${rootPackage}
npm install ${package}

