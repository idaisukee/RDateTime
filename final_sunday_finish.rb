require File.expand_path('../r_date_time.rb',  __FILE__)
require File.expand_path('../float.rb',  __FILE__)

year = RDateTime.now.year
month = ARGV[0].to_i

start = RDateTime.new(year, month, 1)
finish = RDateTime.new(year, month + 1, 1)

array = Range.new(start, finish).to_a

answer = array.select do |d|
	d.wday == 0
end.max

p answer.rc_ajd.floor + 1
