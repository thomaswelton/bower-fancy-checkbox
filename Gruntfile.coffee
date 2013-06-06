module.exports = (grunt) =>
	grunt.initConfig
		pkg: grunt.file.readJSON 'package.json'

		## Compile coffeescript
		coffee:
			compile:
				files: [
					{
						expand: true
						cwd: 'src'
						src: ['FancyCheckbox.coffee']
						dest: 'dist'
						ext: '.js'
					},
					{
						expand: true
						cwd: 'src'
						src: ['main.coffee']
						dest: 'demo'
						ext: '.js'
					}
				]
		
		regarde:
			coffee:
				files: ['src/**/*.coffee']
				tasks: ['coffee', 'requirejs']

			scss:
				files: ['src/**/*.scss']
				tasks: ['sass']

		connect:
			server:
				options:
					keepalive: true
					port: 9001
					base: ''

		exec:
			server:
				command: 'grunt connect &'

			open:
				command: 'open http://localhost:9001/'

		sass:
			dist:
				options:
					style: 'expanded'
				files:
					'dist/FancyCheckbox.css': 'src/FancyCheckbox.scss'

		
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-regarde'
	grunt.loadNpmTasks 'grunt-contrib-connect'
	grunt.loadNpmTasks 'grunt-exec'
	grunt.loadNpmTasks 'grunt-contrib-sass'

	grunt.registerTask 'default', ['compile']

	grunt.registerTask 'server', ['exec:server', 'exec:open', 'watch']

	grunt.registerTask 'commit', ['default', 'git']
	
	grunt.registerTask 'compile', 'Compile coffeescript and scss', ['coffee', 'sass']
	grunt.registerTask 'watch', 'Watch coffee and scss files for changes and recompile', () ->
		## always use force when watching
		grunt.option 'force', true
		grunt.task.run ['regarde']
