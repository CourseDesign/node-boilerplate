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
rootPackage=$(pwd)
scriptPath=${rootPackage}/$(dirname "$0")

echo "🚀 Start to creat new package ${packageName} in ${packageDir}..."

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
echo "add eslintrc file"

node ${scriptPath}/extend-eslint.js ${rootPackage} ${package}
cp ${rootPackage}/.eslintignore .eslintignore

node ${scriptPath}/add-eslint-parse-option.js ${rootPackage} ${package}

# 의존성이 있는 eslint package
# npm install --save-dev eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin
# npm install --save-dev prettier eslint-plugin-prettier eslint-config-prettier
# npm install --save-dev eslint-plugin-import eslint-config-airbnb-base

echo "🎉 Finish lint setting"

# package.json 수정
cd ${rootPackage}

node ${scriptPath}/change-package.js "${package}/package.json" main "dist/index.js"

sh ${scriptPath}/sync-package.sh ${packageDir} ${packageName}

cd ${package}

echo "🎉 Finish to update package.json"

# 소스 파일 폴더 생성
mkdir src

touch src/index.ts

echo "🎉 Finish to create default file"

# git add
git add .

echo "🎉 Finish to add git file"

# package 설치
cd ${rootPackage}
npm install ${package}

echo "🎉 Finish to install ${packageName} in ${packageDir}"
