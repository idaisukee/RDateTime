require File.expand_path('../r_date_time.rb',  __FILE__)
require File.expand_path('../float.rb',  __FILE__)



m = RDateTime.now.new_offset(Rational(9, 24))

prop_rc_year = m.prop_rc_year
str_prop_rc_day = sprintf('%3.3f', m.prop_rc_day.to_f.e_floor(3).to_f)
out_str_prop_rc_day = str_prop_rc_day

str = "#{prop_rc_year}:#{out_str_prop_rc_day}"
print str
