require 'date'
class MyDateTime < DateTime

	RC_EPOCH = self.new(1792, 9, 22, 0, 0, 0, Rational(1, 24))

	def self::leap_year?(prop_rc_year)
		@prop_rc_year = prop_rc_year
		@rc_year = @prop_rc_year + 1
		if @rc_year % 4 == 0 then
			if @rc_year % 100 == 0 then
				if @rc_year % 400 == 0 then
					true
				else
					false
				end
			else
				true
			end
		else
			false
		end
	end



	def self::year_length(prop_rc_year)

		@prop_rc_year = prop_rc_year

		if self::leap_year?(@prop_rc_year) then
			366
		else
			365
		end

	end

	def rc_ajd

		self.ajd - RC_EPOCH.ajd

	end



	def prop_rc_year_day

		@rc_ajd = self.rc_ajd

		@prop_rc_year = 0

		while @rc_ajd >= MyDateTime::year_length(@prop_rc_year)
			@rc_ajd -= MyDateTime::year_length(@prop_rc_year)
			@prop_rc_year += 1
		end

		[ @prop_rc_year, @rc_ajd ]

	end



	def year_ratio

		@rc_ajd = self.rc_ajd

		@prop_rc_year = self.prop_rc_year_day[0]
		@prop_rc_day = self.prop_rc_year_day[1]
		@year_length = MyDateTime::year_length(@prop_rc_year)

		@day_ratio = @prop_rc_day / @year_length

	end



def self::from_prop_rc(prop_rc_year, prop_rc_month, prop_rc_day, rc_hour, rc_min, rc_sec)
	# this method seems to produce a displacement of 1 day.
	@prop_rc_year = prop_rc_year
	@prop_rc_month = prop_rc_month
	@prop_rc_day = prop_rc_day
	@rc_hour = rc_hour
	@rc_min = rc_min
	@rc_sec = rc_sec

	@rc_ajd = 0
	while @prop_rc_year >= 1
		@rc_ajd += MyDateTime::year_length(@prop_rc_year)
		@prop_rc_year -= 1
	end

	@rc_ajd += 30 * @prop_rc_month
	@rc_ajd += @prop_rc_day
	@rc_ajd += Rational(@rc_hour, 10)
	@rc_ajd += Rational(@rc_min, 1000)
	@rc_ajd += Rational(@rc_sec, 100000)

	@rc_ajd
end



	def self.from_ajd(ajd)
		# this method does not work.
		@ajd = ajd
		@jd = @ajd + Rational(1, 2)
		self.jd(@jd)
	end

	def to_jd
		@day = self.jd
		@offset = self.offset
		@secs = self.sec + 60 * ( self.min + 60 * self.hour )
		@time = Rational( @secs, 24 * 60 * 60 )
		@jd = @day + @time
		[@jd, @offset]
	end

end

