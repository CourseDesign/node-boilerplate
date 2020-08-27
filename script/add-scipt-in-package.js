const fs = require('fs');

const packagePath = process.argv[2];
if (packagePath == null) {
  console.error('Package is undefined!');
  process.exit(1);
}

const scriptName = process.argv[3];
if (scriptName == null) {
  console.error('Script name is undefined!');
  process.exit(1);
}

const script = process.argv[4];
if (script == null) {
  console.error('Script is undefined!');
  process.exit(1);
}

const packageJson = require(packagePath);
packageJson.scripts[scriptName] = script;

fs.writeFileSync(packagePath, JSON.stringify(packageJson, null, 2) + '\n');
