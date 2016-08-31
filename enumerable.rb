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
			self.sort_by { |k, v|
				Order[k]
			}
		end
	end
end
