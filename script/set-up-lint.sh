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

# lint 설정
node ${scriptPath}/extend-eslint.js ${rootPackage} ${package}
cp ${rootPackage}/.eslintignore ${package}/.eslintignore

node ${scriptPath}/add-eslint-parse-option.js ${rootPackage} ${package}

# 의존성이 있는 eslint package
# npm install --save-dev eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin
# npm install --save-dev prettier eslint-plugin-prettier eslint-config-prettier
# npm install --save-dev eslint-plugin-import eslint-config-airbnb-base

echo "🎉 Finish lint setting"
