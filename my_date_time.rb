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

		self - RC_EPOCH

	end



	def prop_rc_year_day

		@rc_ajd = self.rc_ajd

		@prop_rc_year = 0

		while @rc_ajd >= 365
			@rc_ajd -= MyDateTime::year_length(@prop_rc_year)
			@prop_rc_year += 1
		end

		[ @prop_rc_year, @rc_ajd ]

	end



	def self.from_ajd(ajd)
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

