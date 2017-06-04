require File.expand_path('../r_date_time.rb',  __FILE__)
require File.expand_path('../float.rb',  __FILE__)

input = STDIN.gets.strip


obj = RDateTime::parse(input)
puts sprintf('%5.4f', obj.rc_ajd.to_f)
