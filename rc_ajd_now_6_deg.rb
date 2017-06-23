require File.expand_path('../r_date_time.rb',  __FILE__)
require File.expand_path('../float.rb',  __FILE__)



m = RDateTime.now.new_offset(Rational(9, 24))
rc_ajd_str = m.rc_ajd.to_f.e_floor(6).to_f.to_s

print rc_ajd_str
