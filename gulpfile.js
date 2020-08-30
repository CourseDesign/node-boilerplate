const gulp = require('gulp');
const ts = require('gulp-typescript');

function getTsconfig(env) {
  if (env != null) {
    return `tsconfig.${env.toLowerCase()}.json`;
  }

  return 'tsconfig.json';
}

const tsProject = ts.createProject(getTsconfig(process.env.NODE_ENV));

const outDir = 'dist'

gulp.task('default', () => tsProject.src()
  .pipe(tsProject())
  .pipe(gulp.dest(outDir))
);
