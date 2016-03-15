module.exports = (grunt) ->
    grunt.initConfig

        pkg: grunt.file.readJSON 'package.json'

        sass:
            frontend:
                options:
                    style: 'compressed'
                files:
                    'assets/css/tmp/yii2-materializecss.tmp.css': 'assets/scss/yii2-materializecss.scss'

        autoprefixer:
            dist:
                options:
                    map: true
                files:
                    'assets/css/tmp/yii2-materializecss.min.css': 'assets/css/tmp/yii2-materializecss.tmp.css'

        uglify:
            frontend:
                files:
                    'assets/js/yii2-materializecss.min.js': 'assets/js/src/main.js'

#        concat:
#            dist_js:
##                src: ['vendor/bower/jquery/dist/jquery.min.js', 'vendor/bower/materialize/dist/js/materialize.min.js', 'assets/js/tmp/yii2-materializecss.tmp.js']
#                src: [
#                    'vendor/bower/jquery/dist/jquery.min.js',
#                    'vendor/bower/materialize/dist/js/materialize.js',
#                    'vendor/prism/prism.js',
#                    'assets/js/tmp/yii2-materializecss.tmp.js'
#                ]
#                dest: 'assets/js/yii2-materializecss.min.js'
#
#            dist_css:
#                src: [
#                    'vendor/bower/materialize/dist/css/materialize.min.css',
#                    'vendor/prism/prism.css',
#                    'assets/css/tmp/yii2-materializecss.min.css'
#                ]
#                dest: 'assets/css/yii2-materializecss.min.css'

        copy:
            main:
                files: [
                    {expand: true, cwd: 'vendor/bower/materialize/dist/font/', src: ['**'], dest: 'assets/fonts/'},
                    {expand: true, cwd: 'vendor/bower/font-awesome/fonts/', src: ['**'], dest: 'assets/fonts/'},
                    {expand: true, cwd: 'vendor/bower/jquery/dist/', src: ['jquery.min.js'], dest: 'assets/js/'},
                    {
                        expand: true,
                        cwd: 'vendor/bower/materialize/dist/js/',
                        src: ['materialize.js'],
                        dest: 'assets/js/'
                    },
                    {expand: true, cwd: 'vendor/prism/', src: ['prism.js'], dest: 'assets/js/'},
                    {expand: true, cwd: 'vendor/bower/clipboard/dist/', src: ['clipboard.min.js'], dest: 'assets/js/'},
                    {
                        expand: true,
                        cwd: 'vendor/bower/materialize/dist/css/',
                        src: ['materialize.min.css'],
                        dest: 'assets/css/'
                    }
                    {expand: true, cwd: 'vendor/prism/', src: ['prism.css'], dest: 'assets/css/'}
                    {expand: true, cwd: 'vendor/bower/font-awesome/css/', src: ['font-awesome.min.css'], dest: 'assets/css/'}
                ]
            css:
                files: [
                    {expand: true, cwd: 'assets/css/tmp/', src: ['yii2-materializecss.min.css'], dest: 'assets/css/'}
                ]

        watch:
            frontend_sass:
                options:
                    livereload: false
                files: 'assets/scss/**/*.scss'
                tasks: ['sass:frontend'] #'sass:backend_dev',

            frontend_autoprefixer:
                files: ['assets/css/tmp/yii2-materializecss.tmp.css']
                tasks: ['autoprefixer:dist']

            frontend_css:
                options:
                    livereload: true
                files: ['assets/css/tmp/yii2-materializecss.min.css']
                tasks: ['copy:css']

            frontend_js:
                options:
                    livereload: true
                files: ['assets/js/src/main.js']
                tasks: ['uglify:frontend']

    grunt.loadNpmTasks 'grunt-contrib-sass'
    grunt.loadNpmTasks 'grunt-autoprefixer'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-contrib-concat'
    grunt.loadNpmTasks 'grunt-contrib-uglify'
    grunt.loadNpmTasks 'grunt-contrib-copy'
    grunt.registerTask 'default', ['watch']