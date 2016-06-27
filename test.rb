require './my_date_time.rb'

m = MyDateTime.now
n = MyDateTime.new(2015, 6, 27, 10, 10, 10, Rational(9, 24))
p m.rc_ajd.to_f 

p MyDateTime::leap_year?(299)
p MyDateTime::leap_year?(399)
p MyDateTime::leap_year?(3)
p MyDateTime::leap_year?(4)

p MyDateTime::year_length(299)
p MyDateTime::year_length(399)

p m.prop_rc_year
p n.prop_rc_year
