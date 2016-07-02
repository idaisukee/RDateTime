require File.expand_path('../r_date_time.rb',  __FILE__)
require File.expand_path('../float.rb',  __FILE__)
require File.expand_path('../range.rb',  __FILE__)

now = RDateTime.now
yera = now.year
min = RDateTime.new(now.year, 1, 1, 8, 0, 0, Rational(9, 24))
max = RDateTime.new(now.year + 1, 1, 1, 8, 0, 0, Rational(9, 24))

range = Range.new(min, max)

range.each do |d|

	gc = sprintf('%02d-%02d', d.month, d.day)
	prc = sprintf('%03d', d.prop_rc_day.floor)
	puts "#{gc}\t#{prc}"
	
end
