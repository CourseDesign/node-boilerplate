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

const diff = path.relative(packagePath, rootPackagePath);

const eslintrc = {
  extends: [
    `${diff}/.eslintrc.json`
  ]
}

fs.writeFileSync(`${packagePath}/.eslintrc.json`, JSON.stringify(eslintrc, null, 2) + '\n');
