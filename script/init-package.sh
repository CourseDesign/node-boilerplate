#!/bin/bash

if [ -z "$1" ]; then
	echo "Package directory is undefined!"
	exit 1
fi

if [ -z "$2" ]; then
	echo "Package name is undefined!"
	exit 1
fi

packageDir=$1
packageName=$2
scriptDir=$(dirname "$0")

echo "🚀 Start to creat new package ${packageName} in ${packageDir}..."

rootPackage=$(pwd)

# 폴더로 이동
mkdir ${packageDir}
cd ${packageDir}

# 폴더 생성
mkdir ${packageName}
cd ${packageName}

echo "🎉 Finish to create new package directory"

package=$(pwd)

# npm 설정
npm init

# typescript 설정
npm i typescript --save-dev
npm i @types/node --save-dev

cp ${rootPackage}/tsconfig.json tsconfig.json

echo "🎉 Finish typescript setting"

# gulp 설정
npm install gulp --save-dev
npm install gulp-typescript --save-dev

cp ${rootPackage}/gulpfile.js gulpfile.js

echo "🎉 Finish gulp setting"

# lint 설정
npm install --save-dev lint-staged
npm install --save-dev typescript eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin
npm install --save-dev prettier eslint-plugin-prettier eslint-config-prettier

cp ${rootPackage}/.eslintrc.json .eslintrc.json
cp ${rootPackage}/.eslintignore .eslintignore

echo "🎉 Finish lint setting"

# package.json 수정

node ${scriptDir}/change-package.js "${package}/package.json" main "dist/index.js"

sh ${scriptDir}/sync-package.sh ${rootPackage} ${package}

echo "🎉 Finish to update package.json"

# 소스 파일 폴더 생성
mkdir src

touch src/index.ts

echo "🎉 Finish to create default file"

# package 설치
cd ${rootPackage}
npm install ${package}

echo "🎉 Finish to install ${packageName} in ${packageDir}"
