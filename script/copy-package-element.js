const fs = require('fs');

const sourcePackagePath = process.argv[2];
if (sourcePackagePath == null) {
  console.error('Source package is undefined!');
  process.exit(1);
}

const sourcePackageJson = require(sourcePackagePath);

const targetPackagePath = process.argv[3];
if (targetPackagePath == null) {
  console.error('Target package is undefined!');
  process.exit(1);
}

const targetPackageJson = require(targetPackagePath);

const key = process.argv[4];
if (key == null) {
  console.error('Key is undefined!');
  process.exit(1);
}

const tokens = key.split('.').reverse();

let source = sourcePackageJson;
let target = targetPackageJson;
while (tokens.length > 1) {
  const token = tokens.pop();

  if (source[token] == null) {
    process.exit(1);
  }
  if (target[token] == null) {
    target[token] = {}
  }

  source = source[token];
  target = target[token];
}

const token = tokens.pop();
target[token] = source[token];

fs.writeFileSync(targetPackagePath, JSON.stringify(targetPackageJson, null, 2) + '\n');
