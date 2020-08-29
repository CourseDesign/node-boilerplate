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
scriptPath=${rootPackage}/$(dirname "$0")

cd ${packageDir}
cd ${packageName}

package=$(pwd)

node ${scriptPath}/copy-package-element.js "${rootPackage}/package.json" "${package}/package.json" "scripts.run"
node ${scriptPath}/copy-package-element.js "${rootPackage}/package.json" "${package}/package.json" "scripts.build"
node ${scriptPath}/copy-package-element.js "${rootPackage}/package.json" "${package}/package.json" "scripts.test"
