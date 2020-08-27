const fs = require('fs');

const packagePath = process.argv[2];
if (packagePath == null) {
  console.error('Package is undefined!');
  process.exit(1);
}

const packageJson = require(packagePath);

const key = process.argv[3];
if (key == null) {
  console.error('Key is undefined!');
  process.exit(1);
}

const value = process.argv[4];
if (value == null) {
  console.error('Value is undefined!');
  process.exit(1);
}

packageJson[key] = value;

fs.writeFileSync(packagePath, JSON.stringify(packageJson, null, 2) + '\n');
