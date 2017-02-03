require File.expand_path('../r_date_time.rb',  __FILE__)
require File.expand_path('../float.rb',  __FILE__)



m = RDateTime.now

str = sprintf('%5.3f', m.rc_ajd).tr('.', 'd')
print str
