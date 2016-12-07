require File.expand_path('../r_date_time', __FILE__ )

r = RDateTime.prop_rc_parse(':333.3')
p r.new_offset(Rational(9, 24))

s = '2016-3-3T'
t = 'T10:10:10'
u = '2016-3-3'
p s.split('T')

p t.split('T')
p u.split('T')

p /a/.match 'abc'
p /d/.match 'abc'
p /\//.match 'ab
'
p RDateTime::rc_parse('224/11/10')
p RDateTime::rc_parse('224/12/10T5').new_offset(Rational(9, 24))
p RDateTime::rc_parse('1.6').new_offset(Rational(9, 24))
p RDateTime::parse('2016/3/3T3:0')
puts
p RDateTime::r_parse('g 2016/3/3T3:40')
p RDateTime::r_parse('pr 223:333.5').rc_time.to_f
p RDateTime::r_parse('r 224/11/30')
p RDateTime::r_parse('g 12/30').rc_time.to_f
p RDateTime::r_parse('g 12:30')

p RDateTime::time_conv_g_pr('11:00')
p RDateTime::time_conv_pr_g('.5')


p RDateTime::date_conv_pr_g('333.9')
p RDateTime::date_conv_g_pr('8/21')
p RDateTime::date_conv_g_pr('8/21')[1].to_f
