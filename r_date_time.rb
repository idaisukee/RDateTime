# -*- coding: utf-8 -*-

# function confirmed on 
# ruby 1.9.3p484 (2013-11-22 revision 43786) [i686-linux]



require 'date'
require File.expand_path('../float.rb', __FILE__)


class RDateTime < DateTime

	RC_EPOCH = self.new(1792, 9, 22, 0, 0, 0, Rational(1, 24))

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
		def leap_year?(prop_rc_year)
			rc_year = prop_rc_year + 1
			if rc_year % 400 == 0 || rc_year % 4 == 0 && rc_year % 100 != 0 then
				true
			else
				false
			end
		end


		def from_jd(jd_array)
			@jd = jd_array[0]
			@offset = jd_array[1]
			@utc_jd = @jd - @offset
			self.jd(@utc_jd)
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



		def from_prop_rc(prop_rc_year, prop_rc_month, prop_rc_day, rc_hour, rc_min, rc_sec)

			rc_ajd = prop_rc_to_rc_ajd(prop_rc_year, prop_rc_month, prop_rc_day, rc_hour, rc_min, rc_sec)
			self::from_rc_ajd(rc_ajd)

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



		def year_length(prop_rc_year)

			@prop_rc_year = prop_rc_year

			if self::leap_year?(@prop_rc_year) then
				366
			else
				365
			end

		end



		def in_jp(year, month, day, hour, minute)

			print "[ 共和暦 #{year} 年 #{month} 月 #{day} 日 #{hour} 時 #{minute} 分 ]"

		end



	end


	def rc_ajd

		self.ajd - RC_EPOCH.ajd

	end



	def in_prop_rc_year?(prop_rc_year)

		range = Range.new( self.class::from_prop_rc(prop_rc_year, 0, 0, 0, 0, 0).ajd, self.class::from_prop_rc(prop_rc_year + 1, 0, 0, 0, 0, 0).ajd, true)
		range.include? self.ajd


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






	def to_jd
		@day = self.jd
		@offset = self.offset
		@secs = self.sec + 60 * ( self.min + 60 * self.hour )
		@time = Rational( @secs, 24 * 60 * 60 )
		@jd = @day + @time
		[@jd, @offset]
	end



	def to_rc_jp

		self.class::in_jp(year, month, day, hour, minute)

	end





	def to_prop_rc_jp

		self.class::in_jp(year, month, day, hour, minute)

	end



	def to_prop_rc

		@ajd = self.ajd
		@rc_ajd = self.rc_ajd
		@prop_rc = self.class::rc_ajd_to_prop_rc(@rc_ajd)

	end



	def prop_rc_year

		@prop_rc_year = self.to_prop_rc[0]

	end



	def prop_rc_day

		@prop_rc_day = self.to_prop_rc[1]

	end



	def prop_rc_month

		Rational(self.prop_rc_day, 30).floor

	end



	def prop_rc_monthday

		( self.prop_rc_day % 30 ).floor.to_i

	end



	def time

		@day = self.rc_ajd.floor
		@time = ( self - @day ).rc_ajd

	end





end
