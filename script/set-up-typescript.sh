#!/bin/bash

if [ -z "$1" ]; then
	echo "Root package is undefined!"
	exit 1
fi

if [ -z "$2" ]; then
	echo "Package is undefined!"
	exit 1
fi

rootPackage=$1
package=$2
scriptPath=${rootPackage}/script

cd ${package}

# typescript 설정
npm i typescript --save-dev
npm i @types/node --save-dev

cp ${rootPackage}/tsconfig.json .
cp ${rootPackage}/tsconfig.*.json .

echo "🎉 Finish typescript setting"
