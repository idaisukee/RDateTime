require File.expand_path('../r_date_time.rb',  __FILE__)
require File.expand_path('../float.rb',  __FILE__)

input = STDIN.gets.strip

rc_ajd = input.to_f

obj = RDateTime::from_rc_ajd(rc_ajd).new_offset(RDateTime::JST)
puts obj
