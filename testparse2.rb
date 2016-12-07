require File.expand_path('../r_date_time', __FILE__ )

p r = RDateTime.prop_rc_parse(':333.3')
p RDateTime::r_parse('g 2016/3/3T3:40')
p RDateTime::r_parse('pr 223:333.5')
p RDateTime::r_parse('r 224/11/30')
p RDateTime::r_parse('g 12/30')
p RDateTime::r_parse('g 12:30')

p RDateTime::r_parse('g 2016/3/3T3:40')
p RDateTime::r_parse('pr 223:333.5')
p RDateTime::r_parse('r 224/11/30')
p RDateTime::r_parse('g 12/30')
p RDateTime::r_parse('g 12:30')
