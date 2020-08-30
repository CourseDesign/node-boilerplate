#!/bin/bash

if [ -z "$1" ]; then
	echo "Source Package is undefined!"
	exit 1
fi

if [ -z "$2" ]; then
	echo "Target Package is undefined!"
	exit 1
fi

rootPackage=$1
package=$2
scriptPath=$3

node ${scriptPath}/copy-package-element.js "${rootPackage}/package.json" "${package}/package.json" "main"
node ${scriptPath}/copy-package-element.js "${rootPackage}/package.json" "${package}/package.json" "jest"
node ${scriptPath}/copy-package-element.js "${rootPackage}/package.json" "${package}/package.json" "scripts.run"
node ${scriptPath}/copy-package-element.js "${rootPackage}/package.json" "${package}/package.json" "scripts.build"
node ${scriptPath}/copy-package-element.js "${rootPackage}/package.json" "${package}/package.json" "scripts.build:production"
node ${scriptPath}/copy-package-element.js "${rootPackage}/package.json" "${package}/package.json" "scripts.test"
node ${scriptPath}/copy-package-element.js "${rootPackage}/package.json" "${package}/package.json" "scripts.install"

