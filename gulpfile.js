var gulp = require('gulp');
var browserSync = require('browser-sync');
var sass = require('gulp-sass');
var prefix = require('gulp-autoprefixer');
var sourcemaps = require('gulp-sourcemaps');
var fs = require('fs');
var rename = require('gulp-rename');
var uglify = require('gulp-uglify');

var tld = fs.readFileSync('/etc/hostname', 'utf8');
var bower = './vendor/bower';

gulp.task('browser-sync', ['sass'], function() {
    var files = [
        './*.html',
        './assets/js/**/*.js'
    ];
    browserSync.init(files, {
        proxy: 'http://yii2-materializecss.github.io.' + tld,
        notify: false,
        online: false,
        ghostMode: {
            clicks: false,
            forms: false,
            scroll: false
        },
        open: false,
        reloadOnRestart: true
    });
});

gulp.task('uglify', function () {
    return gulp.src('./assets/js/src/main.js')
        .pipe(uglify())
        .pipe(rename('yii2-materializecss.min.js'))
        .pipe(gulp.dest('assets/js'));
});

gulp.task('sass', function () {
    return gulp.src('assets/scss/yii2-materializecss.scss')
        .pipe(sourcemaps.init())
        .pipe(sass({
            includePaths: ['scss'],
            outputStyle: 'compressed',
            onError: browserSync.notify
        }).on('error', sass.logError))
        // ['last 15 versions', '> 1%', 'ie 8', 'ie 7'], { cascade: true }
        .pipe(prefix({cascade: true}))
        .pipe(rename('yii2-materializecss.min.css'))
        .pipe(sourcemaps.write())
        .pipe(gulp.dest('assets/css'))
        .pipe(browserSync.reload({stream: true}));
});

gulp.task('copy', function() {
    gulp.src([
        bower + '/clipboard/dist/clipboard.min.js',
        bower + '/jquery/dist/jquery.min.js',
        bower + '/materialize/dist/js/materialize.min.js',
        './vendor/prism/prism.js'
    ])
        .pipe(gulp.dest('./assets/js'));

    gulp.src([
            bower + '/font-awesome/css/font-awesome.min.css',
            bower + '/materialize/dist/css/materialize.min.css',
            './vendor/prism/prism.css'
        ])
        .pipe(gulp.dest('./assets/css'));

    gulp.src(bower + '/font-awesome/fonts/*')
        .pipe(gulp.dest('./assets/fonts'));

    gulp.src(bower + '/materialize/font/**/*')
        .pipe(gulp.dest('./assets/fonts'));
});

gulp.task('watch', function () {
    gulp.watch('assets/scss/**/*.scss', ['sass']);
    gulp.watch('assets/js/src/*.js', ['uglify']);
});

gulp.task('default', ['browser-sync', 'watch']);