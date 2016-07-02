require File.expand_path('../r_date_time.rb',  __FILE__)
require File.expand_path('../float.rb',  __FILE__)
require File.expand_path('../range.rb',  __FILE__)

min = RDateTime.new(2016, 1, 1, 8, 0, 0, Rational(9, 24))
max = min + 1

range = Range.new(min, max)

range.each_n_gc_min(15) do |t|

	rc_date = t.prop_rc_day.floor
	rc_time = t.prop_rc_day - rc_date
	rc_time_i = (rc_time.floor(4) * 10 ** 4).to_i
	rc = sprintf('.%04d', rc_time_i)


	gc_hour = sprintf('%02d', t.hour)
	gc_min = sprintf('%02d', t.min)
	gc = "#{gc_hour}:#{gc_min}"
	print "#{gc}\t#{rc}\n"

end
