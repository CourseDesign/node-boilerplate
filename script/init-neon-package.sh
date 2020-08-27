#!/bin/bash

if [ -z "$1" ]; then
	echo "Source Package is undefined!"
	exit 1
fi

if [ -z "$2" ]; then
	echo "Target Package is undefined!"
	exit 1
fi

packageDir=$1
packageName=$2
rootPackage=$(pwd)
scriptDir=$(dirname "$0")

echo "🚀 Start to creat new package ${packageName} in ${packageDir}..."

# neon 패키지 만들기
npm run neon new ${packageName}

# 패키지 이동
mv ${packageName} ${packageDir}

# 패키지 후처리
cd ${packageDir}/${packageName}
package=$(pwd)

# typescript 설정
npm i typescript --save-dev
npm i @types/node --save-dev

cp ../../tsconfig.json tsconfig.json

echo "🎉 Finish typescript setting"

# gulp 설정
npm install gulp --save-dev
npm install gulp-typescript --save-dev

cp ../../gulpfile.js gulpfile.js

echo "🎉 Finish gulp setting"


mv lib src

# package.json 수정

node ${rootPackage}/${scriptDir}/change-in-package.js "${package}/package.json" main dist/index.js
node ${rootPackage}/${scriptDir}/add-scipt-in-package.js "${package}/package.json" build 'neon build && gulp'
node ${rootPackage}/${scriptDir}/add-scipt-in-package.js "${package}/package.json" install 'npm run build'
node ${rootPackage}/${scriptDir}/add-scipt-in-package.js "${package}/package.json" lint ''
node ${rootPackage}/${scriptDir}/add-scipt-in-package.js "${package}/package.json" test ''

echo "🎉 Finish to update package.json"

# package 설치
cd ${rootPackage}
npm install ${package}

echo "🎉 Finish to install ${packageName} in ${packageDir}"
