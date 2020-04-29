#!/usr/bin/env ruby

def slurp(filename)
	IO.read(filename)
end

$funs = {}

def apply(text)
	applied = text
	
	text.scan(/<!--.+?-->/).each do |comment|
		
		contents = comment[/(?<=<!--).+?(?=-->)/].strip
		
		next if not contents[0].match? /[!$]/
		
		cmd  = contents[0]
		name = contents[/(?<=[!$])\w+/]
		args = contents.scan(/(?<=«).+?(?=»)|[^«»\s]+/)[1..-1]
		
		if cmd === '!'
			body = text[/(?<=#{comment}).+?(?=<!--\s*\.\s*-->)/m]
			
			body = apply(body)
			
			$funs[name] = ->(*given_args) {
				
				processed = body
				
				args.each_with_index do |arg, i|
					processed = processed.gsub("@#{arg}", given_args[i])
				end
				
				processed
				
			}
			
			applied = applied.sub(/#{comment}.*<!--\s*\.\s*-->/m, '')
		elsif cmd === '$'
			my_proc = $funs[name]
			
			abort "called function $#{name} before it was declared in comment #{comment}." if my_proc.nil?
		
			applied = applied.gsub(comment, my_proc.call(*args))
		end
	end
	
	applied
end

puts apply slurp ARGV[0]