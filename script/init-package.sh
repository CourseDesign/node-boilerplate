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
scriptPath=${rootPackage}/script
templatePath=${rootPackage}/template

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
sh ${scriptPath}/set-up-typescript.sh ${rootPackage} ${package}

# gulp 설정
sh ${scriptPath}/set-up-gulp.sh ${rootPackage} ${package}

# lint 설정
sh ${scriptPath}/set-up-lint.sh ${rootPackage} ${package}

# package.json 수정
node ${scriptPath}/change-package.js "${package}/package.json" main "dist/index.js"

sh ${scriptPath}/sync-package.sh ${templatePath}/default ${package} ${scriptPath}

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
