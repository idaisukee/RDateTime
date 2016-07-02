require File.expand_path('../r_date_time.rb',  __FILE__)
require File.expand_path('../float.rb',  __FILE__)

str = STDIN.gets.strip


out = RDateTime.parse(str)

p out.prop_rc_day.to_f.e_floor(3).to_f
