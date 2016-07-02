require File.expand_path('../r_date_time.rb',  __FILE__)
require File.expand_path('../float.rb',  __FILE__)

class Range
	def each_n_gc_min(num)

		@min = self.min
		@max = self.max
		@num = num

		@i = @min
		while @i < @max
			yield(@i)
			@i +=  Rational(@num, 24 * 60)
		end
		
	end



	def each_n_day(num)

		@min = self.min
		@max = self.max
		@num = num

		@i = @min
		while @i < @max
			yield(@i)
			@i +=  @num
		end

		end

end


