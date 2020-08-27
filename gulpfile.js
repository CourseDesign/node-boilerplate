const gulp = require("gulp");
const ts = require("gulp-typescript");

const tsProject = ts.createProject("tsconfig.json");

const outDir = 'dist'

gulp.task('default', () => tsProject.src()
  .pipe(tsProject())
  .pipe(gulp.dest(outDir))
);
