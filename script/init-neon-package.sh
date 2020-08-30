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

# 기존 소스 폴더 변경
mv lib src
echo "🎉 Finish to change src directory"

# typescript 설정
sh ${scriptPath}/set-up-typescript.sh ${rootPackage} ${package}

# gulp 설정
sh ${scriptPath}/set-up-gulp.sh ${rootPackage} ${package}

# lint 설정
sh ${scriptPath}/set-up-lint.sh ${rootPackage} ${package}

# jest 설정
sh ${scriptPath}/set-up-jest.sh ${rootPackage} ${package}

# env 설정
sh ${scriptPath}/set-up-env.sh ${rootPackage} ${package}

# package.json 수정
sh ${scriptPath}/sync-package.sh ${templatePath}/neon ${package} ${scriptPath}

echo "🎉 Finish to update package.json"

# git add
git add .

cat ${rootPackage}/.gitignore >> ${package}/.gitignore

echo "🎉 Finish to add git file"

# package 설치
cd ${rootPackage}
npm install ${package}

echo "🎉 Finish to install ${packageName} in ${packageDir}"
