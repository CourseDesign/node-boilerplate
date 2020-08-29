const fs = require('fs');
const path = require('path');

const rootPackagePath = process.argv[2];
if (rootPackagePath == null) {
    console.error('Root package is undefined!');
    process.exit(1);
}

const packagePath = process.argv[3];
if (packagePath == null) {
    console.error('Package is undefined!');
    process.exit(1);
}
const eslintrcJson = require(`${rootPackagePath}/.eslintrc.json`);

const { project } = eslintrcJson.parserOptions;

const diff = path.relative(rootPackagePath, packagePath);

project.push(`${diff}/tsconfig.json`);

fs.writeFileSync(`${rootPackagePath}/.eslintrc.json`, JSON.stringify(eslintrcJson, null, 2) + '\n');
