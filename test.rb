require './my_date_time.rb'

m = MyDateTime.now

n = MyDateTime.new(2015, 9, 22, 10, 10, 10, Rational(9, 24))

p m.rc_ajd.to_f 
p n.rc_ajd.to_f 

p MyDateTime::leap_year?(299)
p MyDateTime::leap_year?(399)
p MyDateTime::leap_year?(3)
p MyDateTime::leap_year?(4)

p MyDateTime::year_length(299)
p MyDateTime::year_length(399)

p m.prop_rc_year_day
p n.prop_rc_year_day

p m.day_ratio.to_f
p m.day_ratio_in_season.to_f
p n.day_ratio_in_season.to_f

q = MyDateTime::from_prop_rc(223, 9, 9, 1, 52, 10)
p q.to_f
r = MyDateTime::from_prop_rc(10, 0, 0, 1, 52, 10)
p r.to_f
