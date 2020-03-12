#!/usr/bin/env ruby
# coding: utf-8

lines = File.open(ARGV[0],'r').readlines

first_line = lines.shift

if first_line.size > 50
  puts "La primera línea tiene más de 50 caracteres"
  exit 255
end

if lines.size > 0
  second_line = lines.shift.chop

  if second_line != ''
    puts "La segunda línea debe estar vacía"
    exit 255
  end

end

if lines.size > 0

  bad_lines = {}

  lines.each_with_index do |line,i|
    bad_lines[i+2] = line if line.size > 80
  end

  if bad_lines.keys.size > 0
    puts "Todas estas líneas tienen más de 80 caracteres", bad_lines.keys.join(", ")
    exit 255
  end
end



