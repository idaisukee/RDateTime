require File.expand_path('../r_date_time.rb',  __FILE__)
require File.expand_path('../float.rb',  __FILE__)

start = RDateTime.new(2016, 7, 21, 8, 0, 0)
finish = RDateTime.new(2016, 9, 30, 22, 0, 0)

length = finish - start

now = RDateTime.now
used = now - start

ratio = used / length

p ratio.to_f.e_floor(3).to_f

