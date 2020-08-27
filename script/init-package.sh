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

cp ${rootPackage}/tsconfig.json tsconfig.json

echo "🎉 Finish typescript setting"

# gulp 설정
npm install gulp --save-dev
npm install gulp-typescript --save-dev

cp ${rootPackage}/gulpfile.js gulpfile.js

echo "🎉 Finish gulp setting"

# lint 설정
npm install --save-dev lint-staged
npm i --save-dev typescript eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin
npm i --save-dev prettier eslint-plugin-prettier eslint-config-prettier

cp ${rootPackage}/eslint.json eslint.json

echo "🎉 Finish lint setting"

# package.json 수정

node ../../script/change-in-package.js "${package}/package.json" main "dist/index.js"
node ../../script/copy-package-element "${rootPackage}/package.json" "${package}/package.json" lint-staged

node ../../script/copy-package-element "${rootPackage}/package.json" "${package}/package.json" "scripts.run"
node ../../script/copy-package-element "${rootPackage}/package.json" "${package}/package.json" "scripts.build"
node ../../script/copy-package-element "${rootPackage}/package.json" "${package}/package.json" "scripts.lint"
node ../../script/copy-package-element "${rootPackage}/package.json" "${package}/package.json" "scripts.lint:staged"
node ../../script/copy-package-element "${rootPackage}/package.json" "${package}/package.json" "scripts.test"

echo "🎉 Finish to update package.json"

# 소스 파일 폴더 생성
mkdir src

touch src/index.ts

echo "🎉 Finish to create default file"

# package 설치
cd ${rootPackage}
npm install ${package}

echo "🎉 Finish to install $1"

