require File.expand_path('../r_date_time.rb',  __FILE__)
require File.expand_path('../float.rb',  __FILE__)



m = RDateTime.now

prop_rc_year = m.prop_rc_year
prop_rc_day = sprintf('%3.5f', m.prop_rc_day.to_f.e_floor(5).to_f)

str = "#{prop_rc_year}:#{prop_rc_day}"
print str
