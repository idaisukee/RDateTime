require 'date'

class MyDateTime < DateTime
	RC_EPOCH = self.new(1792, 9, 22, 0, 0, 0, Rational(1, 24))
	ONE_YEAR = 365
	FOUR_YEARS = ONE_YEAR * 4 + 1
	ONE_HUNDRED_YEARS = FOUR_YEARS * 25 - 1
	FOUR_HUNDRED_YEARS = ONE_HUNDRED_YEARS * 4 + 1

	def self.from_ajd(ajd)
		@ajd = ajd
		@ajd_date = @ajd.floor
		@ajd_time = @ajd - @ajd_date
		@date = self.jd(@ajd_date)
		@day = 1 * @ajd_time
		@date_time = @date + @day
		
	end

	def arjd
		# astronomic republican julius date: julius date from RC_EPOCH
		(self.ajd.to_f - RC_EPOCH.ajd.to_f)
	end

	def self::from_arjd(arjd)
		@arjd = arjd
		@ajd = @arjd + RC_EPOCH
		self.from_jd(@ajd)
	end


	def self::from_arjd2(arjd)
		@arjd = arjd

		
		p @arjd_day = @arjd.floor

p		@a = @arjd_day / FOUR_HUNDRED_YEARS
p		@b = @arjd_day % FOUR_HUNDRED_YEARS
p		@c = @b / ONE_HUNDRED_YEARS
p		@d = @b % ONE_HUNDRED_YEARS
p		@e = @d / FOUR_YEARS
p		@f = @d % FOUR_YEARS
p		@g = @f / ONE_YEAR
p		@h = @f % ONE_YEAR

p		@year = 400 * @a + 100 * @c + 4 * @e + 1 * @g + 1
p		@day = @h + 1
@time = @arjd - @arjd_day
		[@year, @day, @time]
	end
end


#MyDateTime.new(2016, 6, 21, 3, 4, 5, Rational(9, 24))
d = MyDateTime.new(1792, 9, 22, 3, 4, 5, Rational(1, 24))
p e = d.arjd
f = MyDateTime::from_arjd(e)
puts '---'
p f
p j = MyDateTime.new(2016, 6, 21, 13, 34, 5, Rational(9, 24))
jj	= j.arjd
p MyDateTime::from_arjd(jj)
