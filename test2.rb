require 'test/unit'
require './my_date_time.rb'

class TC < Test::Unit::TestCase

	def test_leap_year?
		assert_equal(true, MyDateTime::leap_year?(223))
		assert_equal(false, MyDateTime::leap_year?(0))
	end



	def test_year_length
		assert_equal(366, MyDateTime::year_length(223))
		assert_equal(365, MyDateTime::year_length(0))
	end



	def test_rc_ajd
		m = MyDateTime::RC_EPOCH
		n = MyDateTime.new(2016, 6, 27, 13, 0, 0, Rational(9, 24))

		assert_equal(0, m.rc_ajd)
		assert_equal(1, (m + 1).rc_ajd)
		assert_equal(1.5, (m + 1.5).rc_ajd)
	end



	def test_prop_rc_year
		m = MyDateTime::RC_EPOCH
		
		assert_equal(0, m.prop_rc_year_day[0])
		assert_equal(1, ( m + 400 ).prop_rc_year_day[0])

		assert_equal([0, 50], ( m + 50 ).prop_rc_year_day)
		assert_equal([1, 0], ( m + 365 ).prop_rc_year_day)
		assert_equal([1, 1], ( m + 366 ).prop_rc_year_day)
		assert_equal([2, 0], ( m + 365 + 365 ).prop_rc_year_day)
		assert_equal([3, 0], ( m + 365 + 365 + 365).prop_rc_year_day)
		assert_equal([3, 365], ( m + 365 + 365 + 365 + 365).prop_rc_year_day)
		assert_equal([4, 0], ( m + 365 + 365 + 365 + 365 + 1).prop_rc_year_day)
		assert_equal([4, 1], ( m + 365 + 365 + 365 + 365 + 1 + 1).prop_rc_year_day)
	end

end
