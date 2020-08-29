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

cd ${package}

# gulp 설정
npm install gulp --save-dev
npm install gulp-typescript --save-dev

cp ${rootPackage}/gulpfile.js gulpfile.js

echo "🎉 Finish gulp setting"
