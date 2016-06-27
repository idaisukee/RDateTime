require './my_date_time.rb'

m = MyDateTime.now
p m.rc_ajd.to_f 

p MyDateTime::leap_year?(299)
p MyDateTime::leap_year?(399)
p MyDateTime::leap_year?(3)
p MyDateTime::leap_year?(4)
