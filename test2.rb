require 'test/unit'
require File.expand_path('../r_date_time.rb',  __FILE__)

class TC < Test::Unit::TestCase

	def test_leap_year?
		assert_equal(true, RDateTime::leap_year?(223))
		assert_equal(false, RDateTime::leap_year?(0))
	end



	def test_year_length
		assert_equal(366, RDateTime::year_length(223))
		assert_equal(365, RDateTime::year_length(0))
	end



	def test_rc_ajd
		m = RDateTime::RC_EPOCH
		n = RDateTime.new(2016, 6, 27, 13, 0, 0, Rational(9, 24))

		assert_equal(0, m.rc_ajd)
		assert_equal(1, (m + 1).rc_ajd)
		assert_equal(1.5, (m + 1.5).rc_ajd)
	end



	def test_from_ajd
		m = RDateTime.new(2016, 6, 27, 13, 0, 0, Rational(9, 24))
		n = RDateTime::from_ajd(m.ajd).new_offset(m.offset)
		assert_equal(m, n)

		u = RDateTime.new(2016, 6, 27, 13, 0, 0, Rational(0, 24))
		s = RDateTime::from_ajd(u.ajd)
		assert_equal(u, s)

		p = RDateTime.new(2016, 6, 27, 13, 0, 0, Rational(5, 24))
		q = RDateTime::from_ajd(p.ajd)

		assert_equal(p, q)

	end



	def test_from_jd
		m = RDateTime.new(2016, 6, 27, 13, 0, 0, Rational(9, 24))
		jda = m.to_jd
		assert_equal(m, RDateTime::from_jd(jda))

		n = RDateTime.new(2016, 6, 27, 13, 0, 0, Rational(0, 24))
		jda = n.to_jd
		assert_equal(n, RDateTime::from_jd(jda))


		o = RDateTime.jd(0)
		p = RDateTime.new(-4712, 1, 1, 0, 0, 0, Rational(0, 24))
		assert_equal(o, p)

		q = RDateTime.from_jd([0, Rational(0, 24)])
		assert_equal(o, q)


	end



	def test_season_ratio

		m = RDateTime.new(2016, 6, 27, 13, 0, 0, Rational(9, 24))
		assert_equal(3, m.season_ratio.floor)

	end



	def test_prop_rc_year_day
		m = RDateTime::RC_EPOCH
		
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



	def test_from_prop_rc
		m = RDateTime.new(2016, 6, 29, 8, 0, 0, Rational(9, 24))
		n = RDateTime.from_prop_rc(223, 9, 11, 0, 0, 0)
		assert_equal(m, n)
	end



	def test_to_jd
		m = RDateTime.new(2016, 6, 29, 8, 0, 0, Rational(9, 24))
		j = m.to_jd[0].floor
		o = m.to_jd[1]
		assert_equal(o, Rational(9, 24))
		assert_equal(j, m.jd)
	end



	def test_jd
		m = RDateTime.jd(0)
		n = RDateTime.new(-4712, 1, 1, 0, 0, 0, Rational(0, 24))
		assert_equal(m, n)
	end
end
