#!/bin/bash

if [ -z "$1" ]; then
	echo "Source Package is undefined!"
	exit 1
fi

if [ -z "$2" ]; then
	echo "Target Package is undefined!"
	exit 1
fi

sourcePackage=$1
targetPackage=$2

scriptDir=$(dirname "$0")

node ${scriptDir}/copy-package-element.js "${sourcePackage}/package.json" "${targetPackage}/package.json" lint-staged

node ${scriptDir}/copy-package-element.js "${sourcePackage}/package.json" "${targetPackage}/package.json" "scripts.run"
node ${scriptDir}/copy-package-element.js "${sourcePackage}/package.json" "${targetPackage}/package.json" "scripts.build"
node ${scriptDir}/copy-package-element.js "${sourcePackage}/package.json" "${targetPackage}/package.json" "scripts.lint"
node ${scriptDir}/copy-package-element.js "${sourcePackage}/package.json" "${targetPackage}/package.json" "scripts.lint:staged"
node ${scriptDir}/copy-package-element.js "${sourcePackage}/package.json" "${targetPackage}/package.json" "scripts.test"


