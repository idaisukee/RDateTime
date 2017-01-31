require File.expand_path('../r_date_time.rb',  __FILE__)
require File.expand_path('../float.rb',  __FILE__)



m = RDateTime.now
str = "#{m.prop_rc_year}:#{m.season_ratio.to_f.e_floor(2).to_f}|#{m.prop_rc_day.to_f.e_floor(3).to_f}"

prop_rc_year = m.prop_rc_year
rc_ajd = m.rc_ajd.to_f
rc_ajd_str = sprintf('%5.3f', rc_ajd)
season_ratio = sprintf('%2.2f', m.season_ratio.to_f.e_floor(2).to_f)

str = "#{rc_ajd_str} ( #{season_ratio} )"
print str
