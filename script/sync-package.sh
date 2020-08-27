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

cd packageDir
cd packageName

node ${scriptDir}/copy-package-element.js "${rootPackage}/package.json" "./package.json" lint-staged

node ${scriptDir}/copy-package-element.js "${rootPackage}/package.json" "./package.json" "scripts.run"
node ${scriptDir}/copy-package-element.js "${rootPackage}/package.json" "./package.json" "scripts.build"
node ${scriptDir}/copy-package-element.js "${rootPackage}/package.json" "./package.json" "scripts.lint"
node ${scriptDir}/copy-package-element.js "${rootPackage}/package.json" "./package.json" "scripts.lint:staged"
node ${scriptDir}/copy-package-element.js "${rootPackage}/package.json" "./package.json" "scripts.test"
