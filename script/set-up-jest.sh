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

# jest 설정
npm i jest @types/jest ts-jest --save-dev

echo "🎉 Finish jest setting"
