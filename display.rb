require File.expand_path('../r_date_time.rb',  __FILE__)
require File.expand_path('../float.rb',  __FILE__)



m = RDateTime.now
str = "#{m.prop_rc_year}:#{m.season_ratio.to_f.e_floor(2).to_f}|#{m.prop_rc_day.to_f.e_floor(3).to_f}"
print str