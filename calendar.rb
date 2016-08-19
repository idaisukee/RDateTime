#!/usr/bin/ruby

require File.expand_path('../r_date_time.rb',  File.realpath(__FILE__))
require File.expand_path('../float.rb',  File.realpath(__FILE__))
require File.expand_path('../range.rb',  File.realpath(__FILE__))


now = RDateTime.now

year = now.year
month = now.month
day = now.day

today = RDateTime.new(year, month, day, 10, 0)


start = today - 15
finish = today + 15

range = Range.new(start, finish)

range.each_n_day(1) do |day|
	gc_array = [day.year, day.month, day.day]
	prc_array = [day.prop_rc_year, day.prop_rc_day.floor]

	gc_str = gc_array.join('/')
	prc_str = prc_array.join(':')

	puts gc_str + "\t" + prc_str
end
