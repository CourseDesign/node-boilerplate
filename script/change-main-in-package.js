const fs = require('fs');

const packagePath = process.argv[2];
if (packagePath == null) {
  console.error('Package is undefined!');
  process.exit(1);
}

const packageJson = require(packagePath);

const mainScript = process.argv[3];
if (mainScript == null) {
  console.error('Main script is undefined!');
  process.exit(1);
}

packageJson['main'] = mainScript;

fs.writeFileSync(packagePath, JSON.stringify(packageJson, null, 2));