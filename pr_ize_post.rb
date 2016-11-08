require File.expand_path('../r_date_time.rb',  __FILE__)
require File.expand_path('../float.rb',  __FILE__)


file = ARGV[0]
File.open(file, 'r') do |file|
	file.each_line do |line|



		if /- time/.match line
			array = line.split(' ')
			year = array[2].to_i

			month = array[3][0..1].to_i
			day = array[3][2..3].to_i

			hour = array[4][0..1].to_i
			min = array[4][2..3].to_i

			r = RDateTime.new(year, month, day, hour, min, 0, Rational(9, 24))
			ry = r.prop_rc_year
			rd = r.prop_rc_day.to_f.e_floor(3).to_f
			str = ry.to_s + ':' + rd.to_s
			out_str = '- prd: ' + str
			puts out_str
			rc_ajd_str = r.rc_ajd.to_f.e_floor(3).to_f.to_s
			out_rc_ajd_str = '  rc_ajd: ' + rc_ajd_str
			puts out_rc_ajd_str
		else
			print line
		end

	end
end
