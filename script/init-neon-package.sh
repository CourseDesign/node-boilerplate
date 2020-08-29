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
scriptPath=${rootPackage}/script
templatePath=${rootPackage}/template

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

# 기존 소스 폴더 변경

mv lib src

echo "🎉 Finish to change src directory"

# package.json 수정
node ${scriptPath}/change-package.js "${package}/package.json" main "dist/index.js"

sh ${scriptPath}/sync-package.sh ${templatePath}/neon ${package} ${scriptPath}

echo "🎉 Finish to update package.json"

# git add
git add .

echo "🎉 Finish to add git file"

# package 설치
cd ${rootPackage}
npm install ${package}

echo "🎉 Finish to install ${packageName} in ${packageDir}"
