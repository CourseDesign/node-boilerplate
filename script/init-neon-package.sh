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

# package 설치
cd ${rootPackage}
npm install ${package}

echo "🎉 Finish to install ${packageName} in ${packageDir}"
