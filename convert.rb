require File.expand_path('../r_date_time.rb',  __FILE__)
require File.expand_path('../float.rb',  __FILE__)

str = STDIN.gets.strip

array = str.split(' ')

system = array[0]

case system
when 'g'
when 'pr'
end


out = RDateTime.r_parse(str)

puts out


