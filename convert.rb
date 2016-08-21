require File.expand_path('../r_date_time.rb',  __FILE__)
require File.expand_path('../float.rb',  __FILE__)

str = STDIN.gets.strip

array = str.split(' ')

system = array[0]

ret = RDateTime.r_parse(str)
type = ret[0]
obj = ret[1]
out = Array.new



case system
when 'g'
	if type.include? 'year' then
		out << obj.prop_rc_year 
	else
		out << ''
	end
	day = obj.prop_rc_day
	if type.include? 'time' then
		out_day = day.to_f
	else
		out_day = day.floor
	end
	out << out_day
	puts out.join(':')

when 'pr'

	date = Array.new
	time = Array.new

	date << obj.year if type.include? 'year'
	date << obj.month if type.include? 'month'
	date << obj.monthday if type.include? 'monthday'
	date << obj.day if type.include? 'day'
	if type.include? 'time' then
		time << obj.hour 
		time << obj.min
	end
	date_str = date.join('/')
	time_str = time.join(':')
	out = [date_str, time_str]
	if out.any? { |i|
			i == ''
		} then
		out_str = out.join('')
	else
		out_str = out.join('T')
	end
	puts out_str

end
