module Enumerable

	Order = {
		:year => 0,
		:month => 1,
		:day => 2,
		:hour => 3,
		:min => 4,
		:sec => 5,
		:offset => 6,
	}



	def arg_sort

		if self.class == Array then
			self.sort_by {|item|
				Order[item]
			}
		elsif
		 self.class == Hash then
			array = self.sort_by { |k, v|
				Order[k]
			}
			hash = Hash.new
			array.each do |k, v|
				hash[k] = v
			end
			hash
		end
	end
end

# b = { :year => 3,
# 			:hour => 5 , :day => 4}
# p b.arg_sort
# p b.arg_sort.values
# p *b
