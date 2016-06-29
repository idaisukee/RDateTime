require './r_date_time.rb'
require './float.rb'

m = RDateTime.now

n = RDateTime.new(2015, 9, 22, 10, 10, 10, Rational(9, 24))

p m.rc_ajd.to_f 
p n.rc_ajd.to_f 

p RDateTime::leap_year?(299)
p RDateTime::leap_year?(399)
p RDateTime::leap_year?(3)
p RDateTime::leap_year?(4)

p RDateTime::year_length(299)
p RDateTime::year_length(399)

p m.prop_rc_year_day
p n.prop_rc_year_day


q = RDateTime::from_prop_rc(223, 9, 9, 1, 52, 10)
p q.to_f
r = RDateTime::from_prop_rc(10, 0, 0, 1, 52, 10)
p r.to_f

p m.prop_rc_year_day
p m.prop_rc_year_day[1].to_f


puts "#{m.prop_rc_year_day[0]}:#{m.prop_rc_year_day[1].to_f }"

p 1.33.class
p 1.23456.e_floor
p 1.23456.e_floor(3).to_f
