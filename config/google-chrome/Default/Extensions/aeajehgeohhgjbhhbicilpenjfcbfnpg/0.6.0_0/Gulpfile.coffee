gulp        = require 'gulp'
gutil       = require 'gulp-util'
exec        = require('child_process').exec;
sass        = require 'gulp-sass'
coffeelint  = require 'gulp-coffeelint'
coffee      = require 'gulp-coffee'
concat      = require 'gulp-concat'
uglify      = require 'gulp-uglify'
webp        = require 'gulp-webp'
zip         = require 'gulp-zip'

gulp.task 'coffee', ->
  gulp.src('./src/*.coffee')
  .pipe(coffee({bare: true}).on('error', gutil.log))
  .pipe(gulp.dest('./dist/js/'))

gulp.task 'sass', ->
  gulp.src('./sass/*.scss') # we defined that at the top of the file
  .pipe(sass({outputStyle: 'compressed', errLogToConsole: true}))
  .pipe(gulp.dest('./dist/css/'))

gulp.task 'webp', ->
  gulp.src('dist/images/*.jpg')
  .pipe(webp())
  .pipe(gulp.dest('dist/images/'));

gulp.task 'release', (cb) ->
  exec 'cp -pr ../plugin/ ../release', ->
    exec 'rm -rf ../release/node_modules ../release/sass ../release/src', ->
      exec 'cd ../release; zip -r ../release.zip .', ->
        exec 'rm -rf ../release', -> cb()

gulp.task 'watch', ->
  gulp.watch './src/*.coffee', ['coffee']
  gulp.watch './sass/*.scss', ['sass']

gulp.task 'default', ['coffee', 'sass']
