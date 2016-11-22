require File.expand_path('../r_date_time.rb',  __FILE__)
require File.expand_path('../float.rb',  __FILE__)

start = RDateTime::prop_rc_parse('224:61.125')[1]
finish = RDateTime::prop_rc_parse('224:61.4166')[1]

length = finish - start

now = RDateTime.now
used = now - start

ratio = used / length

p ratio.to_f.e_floor(3).to_f

