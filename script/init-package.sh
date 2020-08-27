#!/bin/bash

if [ -z "$1" ]; then
	echo "Package name is undefined!"
	exit 1
else
  echo "Package name is "$1
fi

echo "🚀 Start to creat new package $1..."

rootPackage=$(pwd)

# 폴더로 이동
cd package

# 폴더 생성
mkdir $1
cd $1

echo "🎉 Finish to create new package directory"

package=$(pwd)

# npm 설정
npm init

# typescript 설정
npm i typescript --save-dev
npm i @types/node --save-dev

cp ../../tsconfig.json tsconfig.json

echo "🎉 Finish typescript setting"

# gulp 설정
npm install gulp --save-dev
npm install gulp-typescript --save-dev

cp ../../gulpfile.js gulpfile.js

node ../../script/add-scipt-in-package.js "${package}/package.json" build gulp
node ../../script/change-in-package.js "${package}/package.json" main dist/index.js

echo "🎉 Finish gulp setting"

# 소스 파일 폴더 생성
mkdir src

touch src/index.ts

echo "🎉 Finish to create default file"

# package 설치
cd ${rootPackage}
npm install ${package}

echo "🎉 Finish to install $1"

