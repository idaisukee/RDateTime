require File.expand_path('../r_date_time.rb',  __FILE__)
require File.expand_path('../float.rb',  __FILE__)



m = RDateTime.now
str = "#{m.prop_rc_year}:#{m.season_ratio.to_f.e_floor(2).to_f}|#{m.prop_rc_day.to_f.e_floor(3).to_f}"

prop_rc_year = m.prop_rc_year
season_ratio = sprintf('%2.2f', m.season_ratio.to_f.e_floor(2).to_f)
prop_rc_day = sprintf('%3.3f', m.prop_rc_day.to_f.e_floor(3).to_f)

str = "#{prop_rc_year}:#{prop_rc_day} ( #{season_ratio} )"
print str
