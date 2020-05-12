#!/usr/bin/env ruby

require 'erb'
require 'pathname'

class Fixture
	attr_accessor :var_name, :contents

	def initialize(var_name, contents)
		@var_name = var_name
		@contents = contents
	end
end

class Renderer
	attr_accessor :fixtures

	def initialize(fixtures)
		@fixtures = fixtures
	end

	def get_binding
    	binding()
  	end
end

def main
	ast_file_path = ARGV[0]
	template_path = ARGV[1]
	output_path = ARGV[2]
	ast_file_contents = File.read(ast_file_path)
	source_files = ast_file_contents.split(/(?=\(source_file)/)
	filename_regex = %r{\(source_file "(.*)"}
	fixtures = []
	source_files.each do |f|
		if found = f.match(filename_regex)
			fixture_name = Pathname.new(found[1]).basename('.swift')
			if fixture_name.to_s != "main"
				fixtures += [Fixture.new(fixture_name, f)]
			end
		end
	end
	renderer = Renderer.new(fixtures)
	generated_path = Pathname.new(output_path)
	erb_template = ERB.new(File.read(template_path))
	output = erb_template.result(renderer.get_binding)
	swift_file = File.open(generated_path, 'w')
	swift_file.puts output
end

main
