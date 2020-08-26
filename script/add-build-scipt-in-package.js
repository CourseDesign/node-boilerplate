const fs = require('fs');

const packagePath = process.argv[2];
if (packagePath == null) {
  console.error('Package is undefined!');
  process.exit(1);
}

const packageJson = require(packagePath);
packageJson.scripts['build'] = 'tsc';

fs.writeFileSync(packagePath, JSON.stringify(packageJson, null, 2));