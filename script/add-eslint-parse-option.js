const fs = require('fs');

const packageName = process.argv[2];
if (packageName == null) {
    console.error('Package name is undefined!');
    process.exit(1);
}

const eslintrcJson = require('../.eslintrc.json');

const { project } = eslintrcJson.parserOptions;

project.push(`./package/${packageName}/tsconfig.json`);

fs.writeFileSync('./.eslintrc.json', JSON.stringify(eslintrcJson, null, 2) + '\n');
