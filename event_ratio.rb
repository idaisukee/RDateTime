require File.expand_path('../r_date_time.rb',  __FILE__)
require File.expand_path('../float.rb',  __FILE__)

arg_start = ARGV[0].strip.to_f
arg_finish = ARGV[1].strip.to_f

start = RDateTime::from_rc_ajd(arg_start)
finish = RDateTime::from_rc_ajd(arg_finish)

length = finish - start

now = RDateTime.now
used = now - start

ratio = used / length

p ratio.to_f.e_floor(3).to_f

