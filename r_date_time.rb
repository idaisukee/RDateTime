# -*- coding: utf-8 -*-

# function confirmed on 
# ruby 1.9.3p484 (2013-11-22 revision 43786) [i686-linux]



require 'date'
require File.expand_path('../float.rb', __FILE__)


class RDateTime < DateTime

	RC_EPOCH = self.new(1792, 9, 22, 0, 0, 0, Rational(1, 24))

	JST = Rational(9, 24)

	## object generation cascade
	# rc
	# -> prop_rc
	# -> rc_ajd : covered
	# -> ajd : covered
	# -> jd : covered
	# -> object : covered

	## object displaying styles
	# status bar style (like 223:3.14|287.181)
	# jp style (like 共和暦 224 年 10 月 18 日 1 時 81 分)

	## object displaying cascade
	# object
	# -> ajd
	# -> prop_rc

	class << self

		#
		# small methods
		#

		def in_jp(year, month, day, hour, minute)

			"[ 共和暦 #{year} 年 #{month} 月 #{day} 日 #{hour} 時 #{minute} 分 ]"

		end



		def leap_year?(prop_rc_year)
			rc_year = prop_rc_year + 1
			if rc_year % 400 == 0 || rc_year % 4 == 0 && rc_year % 100 != 0 then
				true
			else
				false
			end
		end



		def prop_rc_to_rc(prop_rc_year, prop_rc_month, prop_rc_day, rc_hour, rc_min, rc_sec)

			rc_year = prop_rc_year + 1
			rc_month = prop_rc_month + 1
			rc_day = prop_rc_day + 1

			[rc_year, rc_month, rc_day, rc_hour, rc_min, rc_sec]

		end



		def prop_rc_to_rc_ajd(prop_rc_year, prop_rc_month, prop_rc_day, rc_hour, rc_min, rc_sec)
			# this method seems to produce a displacement of 1 day.

			rc_ajd = 0

			rc_ajd += self::prop_rc_year_to_rc_ajd(prop_rc_year)

			rc_ajd += 30 * prop_rc_month
			rc_ajd += prop_rc_day
			rc_ajd += Rational(rc_hour, 10)
			rc_ajd += Rational(rc_min, 1000)
			rc_ajd += Rational(rc_sec, 100000)

			rc_ajd
		end



		def prop_rc_year_to_past_days(prop_rc_year)

			if prop_rc_year == 0 then
				0
			else

				range = Range.new(0, prop_rc_year - 1)
				array = range.to_a

				days = array.map do |y|
					self::year_length(y)
				end

				past_days = days.inject(:+)

			end

		end



		def rc_ajd_to_prop_rc_year_candidates(rc_ajd)
			
			temp_prop_rc_year = (rc_ajd / 365.25).floor
			range = Range.new(temp_prop_rc_year - 1, temp_prop_rc_year + 1)

			array = range.to_a.select do |y|
				y >= 0
			end

		end



		def prop_rc_year_candidates_to_rc_ajd(prop_rc_candidates)
			prop_rc_candidates.map do |y|
				prop_rc_year_to_rc_ajd(y)
			end
		end



		def rc_ajd_to_prop_rc_year(rc_ajd)

			candidates = self::rc_ajd_to_prop_rc_year_candidates(rc_ajd)
			days = self::prop_rc_year_candidates_to_rc_ajd(candidates)

			correct_day = days.select do |d|
				d <= rc_ajd
			end.max

			correct_prop_rc_year = candidates.select do |y|
				RDateTime::prop_rc_year_to_rc_ajd(y) == correct_day
			end[0]

		end



		def rc_ajd_to_prop_rc(rc_ajd)

			prop_rc_year = self::rc_ajd_to_prop_rc_year(rc_ajd)
			past_days = self::prop_rc_year_to_past_days(prop_rc_year)
			prop_rc_day = rc_ajd - past_days

			[prop_rc_year, prop_rc_day]

		end



		def rc_ajd_to_ajd(rc_ajd)
			ajd = rc_ajd + self::RC_EPOCH.ajd
		end



		def prop_rc_year_to_rc_ajd(prop_rc_year)

			if prop_rc_year == 0 then
				0
			else
				array = Range.new(0, prop_rc_year - 1).to_a
				days = array.map do |i|
					self::year_length(i)
				end
				days_sum = days.inject(:+)
			end
			
		end



		def year_length(prop_rc_year)

			@prop_rc_year = prop_rc_year

			if self::leap_year?(@prop_rc_year) then
				366
			else
				365
			end

		end

		#
		# object generator
		#

		def from_jd(jd_array)
			@jd = jd_array[0]
			@offset = jd_array[1]
			@utc_jd = @jd - @offset
			self.jd(@utc_jd)
		end



		def from_prop_rc(prop_rc_year, prop_rc_month, prop_rc_day, rc_hour, rc_min, rc_sec)

			rc_ajd = prop_rc_to_rc_ajd(prop_rc_year, prop_rc_month, prop_rc_day, rc_hour, rc_min, rc_sec)
			self::from_rc_ajd(rc_ajd)

		end



		def from_ajd(ajd)
			@ajd = ajd
			@jd = @ajd + Rational(1, 2)
			self.jd(@jd)
		end



		def from_rc_ajd(rc_ajd)
			@rc_ajd = rc_ajd
			@ajd = self::RC_EPOCH.ajd + @rc_ajd
			self::from_ajd(@ajd)
		end



		#
		# parser
		#



		def prop_rc_parse(str)

			array = str.split(':')
			type = Array.new

			case array.size

				when 1
				if str[-1] == ':' then
					prop_rc_year = array[0].to_i
					prop_rc_day = 0
					type << 'year'
				else
					time = str.to_f
					prop_rc_year = self.now.prop_rc_year
					prop_rc_day = self.now.prop_rc_day.floor + time
					type << time
				end

				when 2

				if str[0] == ':' then
					prop_rc_year = self.now.prop_rc_year
					prop_rc_day = array[1].to_r
					type << 'month'
					type << 'day'
				else
					prop_rc_year = array[0].to_i
					prop_rc_day = array[1].to_r
					type << 'year'
					type << 'month'
					type << 'day'
				end

			end

			if /\./.match str then
				type << 'time'
			end

			rc_ajd = self::prop_rc_year_to_past_days(prop_rc_year) + prop_rc_day

			obj = self::from_rc_ajd(rc_ajd).new_offset(JST)
			[type, obj]
		end



		def rc_parse(str)

			array = str.split('T')
			type = Array.new

			case array.size

			when 1
				real_str = array[0]
				if /\//.match(real_str) then
					date = real_str
					time = '0'
					type << 'date'
				else
					if /./.match(real_str) then
						date = [self.now.prop_rc_year + 1, self.now.prop_rc_month + 1, self.now.prop_rc_monthday + 1].join('/')
						time = real_str
						type << 'time'
					end
				end
			when 2
				date = array[0]
				time = array[1]
				type << 'date'
				type << 'time'
			end
			
			date_array = date.split('/')

			case date_array.size

			when 2
				rc_year = self.now.prop_rc_year + 1
				rc_month = date_array[0].to_i
				rc_monthday = date_array[1].to_i
				type << 'month'
				type << 'monthday'
			when 3
				rc_year = date_array[0].to_i
				rc_month = date_array[1].to_i
				rc_monthday = date_array[2].to_i
				type << 'year'
				type << 'month'
				type << 'monthday'

			end
			
			prop_rc_year = rc_year - 1
			prop_rc_month = rc_month - 1
			prop_rc_monthday = rc_monthday - 1
			prop_rc_time = time.to_r / 10

			prop_rc_day =  30 * prop_rc_month + prop_rc_monthday + prop_rc_time
			rc_ajd = self::prop_rc_year_to_past_days(prop_rc_year) + prop_rc_day

			obj = self::from_rc_ajd(rc_ajd).new_offset(JST)
			[type, obj]
		end



		def g_parse(str)

			array = str.split('T')
			type = Array.new

			case array.size

			when 1
				real_str = array[0]
				if /:/.match(real_str) then
					date = [self.now.year, self.now.month, self.now.day].join('/')
					type << 'time'
				else
					date = real_str
					type << 'date'
				end
			when 2
				date = array[0]
				type << 'date'
				type << 'time'
			end
			
			date_array = date.split('/')

			case date_array.size

			when 1
				type << 'year'
				year = date_array[0].to_i
				obj = self.new(year, 1, 1, 0, 0, 0, JST)
			when 2
				type << 'month'
				type << 'monthday'
				obj = (self::parse(str) - JST).new_offset(JST)
			when 3
				type << 'year'
				type << 'month'
				type << 'monthday'
				obj = (self::parse(str) - JST).new_offset(JST)

			end

			[type, obj]
		end

		def r_parse(str)
			array = str.split(' ')
			case array[0]
			when 'pr'
				self::prop_rc_parse(array[1])
			when 'r'
				self::rc_parse(array[1])
			when 'g'
				self::g_parse(array[1])
			end
		end



		def g_time_parse(str)
			array = str.split(':')
			hour = array[0].to_i
			min = array[1].to_i
			arg = ['hour', 'min']
			now = self.now
			year = now.year
			month = now.month
			monthday = now.day
			sec = now.sec
			obj = self::new(year, month, monthday, hour, min, sec, JST)
			[obj, arg]
		end


		def g_3_piece_date_parse(str)
			array = str.split('/')
			year = array[0].to_i
			month = array[1].to_i
			monthday = array[2].to_i
			arg = ['year', 'month', 'day']
			now = self.now
			hour = now.hour
			min = now.min
			sec = now.sec
			obj = self::new(year, month, monthday, hour, min, sec, JST)
			[obj, arg]
		end



		def g_2_piece_date_parse(str)
			array = str.split('/')
			now = self.now
			year = now.year
			month = array[0].to_i
			monthday = array[1].to_i
			arg = ['month', 'day']
			hour = now.hour
			min = now.min
			sec = now.sec
			obj = self::new(year, month, monthday, hour, min, sec, JST)
			[obj, arg]
		end



		#
		# postparser
		#


		def merge(array1, array2)

			whole = ['year', 'month', 'day', 'hour', 'min', 'sec']

			arg1 = array1[1]
			arg2 = array2[2]

			merged_arg = arg1 + arg2

		end

		#
		# converter
		#



		def time_conv_g_pr(str)

			obj = self::g_parse(str)
			obj.rc_time

		end



		def time_conv_pr_g(str)
			real_str = ':' + str
			obj = self::prop_rc_parse(real_str)
			[obj.hour, obj.min]
		end



		def date_conv_g_pr(str)

			obj = self::g_parse(str)
			[obj.prop_rc_year, obj.prop_rc_day]

		end



		def date_conv_pr_g(str)

			real_str = ':' + str
			obj = self::prop_rc_parse(real_str)
			[obj.year, obj.month, obj.day]

		end




	end


	#
	# properties
	#



	def r_jd
		@day = self.jd
		@offset = self.offset
		@secs = self.sec + 60 * ( self.min + 60 * self.hour )
		@time = Rational( @secs, 24 * 60 * 60 )
		@jd = @day + @time
		[@jd, @offset]
	end



	def rc_ajd

		self.ajd - RC_EPOCH.ajd

	end



	def prop_rc_year_day

		@rc_ajd = self.rc_ajd

		@prop_rc_year = 0

		while @rc_ajd >= RDateTime::year_length(@prop_rc_year)
			@rc_ajd -= RDateTime::year_length(@prop_rc_year)
			@prop_rc_year += 1
		end

		[ @prop_rc_year, @rc_ajd ]

	end



	def year_ratio

		@rc_ajd = self.rc_ajd

		@prop_rc_year = self.prop_rc_year
		@prop_rc_day = self.prop_rc_day
		@year_length = RDateTime::year_length(@prop_rc_year)

		@day_ratio = @prop_rc_day / @year_length

	end



	def season_ratio

		self.year_ratio * 4

	end



	def prop_rc_year

		@prop_rc_year = self.prop_rc_year_day[0]

	end



	def prop_rc_day

		@prop_rc_year = self.prop_rc_year_day[1]

	end



	def prop_rc_month

		Rational(self.prop_rc_day, 30).floor

	end



	def prop_rc_monthday

		( self.prop_rc_day % 30 ).floor.to_i

	end



	def rc_time

		@day = self.rc_ajd.floor
		@time = ( self - @day ).rc_ajd

	end



	def rc_hour

		@time = self.rc_time.to_f.to_s
		@hour = @time[2].to_i

	end



	def rc_minute

		@time = self.rc_time.to_f.to_s
		@hour = @time[3..4].to_i

	end


	#
	# small methods
	#



	def in_prop_rc_year?(prop_rc_year)

		range = Range.new( self.class::from_prop_rc(prop_rc_year, 0, 0, 0, 0, 0).ajd, self.class::from_prop_rc(prop_rc_year + 1, 0, 0, 0, 0, 0).ajd, true)
		range.include? self.ajd


	end



	#
	# outputer
	#






	def to_rc_jp

		self.class::in_jp(year, month, day, hour, minute)

	end



	def to_prop_rc_jp

		self.class::in_jp(self.prop_rc_year, self.prop_rc_month, self.prop_rc_monthday, self.rc_hour, self.rc_minute)

	end



	def to_prop_rc

		@ajd = self.ajd
		@rc_ajd = self.rc_ajd
		@prop_rc = self.class::rc_ajd_to_prop_rc(@rc_ajd)

	end




		



end
