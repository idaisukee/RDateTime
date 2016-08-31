require File.expand_path('../r_date_time.rb',  __FILE__)
require File.expand_path('../float.rb',  __FILE__)

m = RDateTime.now
p m.prop_rc_int_day
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


#q = RDateTime::from_prop_rc(223, 9, 9, 1, 52, 10)

#r = RDateTime::from_prop_rc(10, 0, 0, 1, 52, 10)

p m.prop_rc_year_day
p m.prop_rc_year_day[1].to_f


puts "#{m.prop_rc_year_day[0]}:#{m.prop_rc_year_day[1].to_f }"

p 1.33.class
p 1.23456.e_floor
p 1.23456.e_floor(3).to_f

p File.expand_path('../float.rb', __FILE__)
#p m.year_ratio.to_f

p m.class::RC_EPOCH

p Range.new(0, 3).to_a

i = 2000
p c = RDateTime::rc_ajd_to_prop_rc_year_candidates(i)
p RDateTime::prop_rc_year_candidates_to_rc_ajd(c)
p RDateTime::rc_ajd_to_prop_rc_year(i)

p RDateTime::prop_rc_year_to_past_days(5)
p RDateTime::rc_ajd_to_prop_rc(1827)

n = RDateTime.now
n.in_prop_rc_year?(223)

a = (n - 1).new_offset(0)
b = (n + 1).new_offset(0)

p Range.new(a, b, true).include? n


p n.to_prop_rc[1].to_f
p n.prop_rc_year
p n.prop_rc_day.to_f

p n.prop_rc_monthday
p n.rc_minute
print n.to_prop_rc_jp
puts
p RDateTime.g_time_parse('11:30')
p RDateTime.g_3_piece_date_parse('2000/10/10')
#p RDateTime.g_2_piece_date_parse('10/10')
#p RDateTime::supplement(['year'])
#p RDateTime::from_g_hash({'year' => 2000, 'month' => 3, 'day' => 3, 'hour' => 3, 'min' => 3, 'sec' => 3, 'offset' => 0})
#p RDateTime::from_g_partial_hash({'year' => 2000,})

#p n.args = 3
#p n.supplement = ['year', 'month', 'day']
#p n.to_s_supplement



#p n.prop_rc_int_day
