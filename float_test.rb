require 'test/unit'
require './float.rb'

class TC < Test::Unit::TestCase
	def test_e_floor
		assert_equal(0.1234.e_floor(3), 0.123)
	end
end
