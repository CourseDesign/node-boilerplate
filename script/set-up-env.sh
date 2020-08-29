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

# env 설정
npm i cross-env --save-dev

echo "🎉 Finish env setting"
