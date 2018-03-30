require File.expand_path('../r_date_time.rb',  __FILE__)
require File.expand_path('../float.rb',  __FILE__)



m = RDateTime.now

prop_rc_year = m.prop_rc_year
rc_ajd = m.rc_ajd.to_f
rc_ajd_str = sprintf('%5.5f', rc_ajd)
season_ratio = m.season_ratio.to_f
season_ratio_str = sprintf('%1.2f', season_ratio)

JULIUS_YEAR = 365.22
AVR_LIFE = 80.79 * JULIUS_YEAR

life_start = RDateTime.new(1983, 6, 9, 0, 0, 0, RDateTime::JST)
life_end = life_start + AVR_LIFE
life_length = life_end - life_start
life_past = m - life_start
life_ratio = life_past / life_length
life_past_str = sprintf('%5.0f', life_past.floor)
life_ratio_str = sprintf('%.3f', life_ratio)

str = "#{rc_ajd_str} ( #{life_past_str} #{life_ratio_str} #{season_ratio_str} )"
print str
