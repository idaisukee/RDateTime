require 'test/unit'
require File.expand_path('../r_date_time.rb',  __FILE__)

class TC < Test::Unit::TestCase



	def setup

		@@t = RDateTime.new(2016, 6, 27, 13, 0, 0, Rational(9, 24)) # Tokyo
		@@rc_epoch = RDateTime::RC_EPOCH
		@@l = RDateTime.new(2016, 6, 27, 13, 0, 0, Rational(0, 24)) # London
	end



	def test_leap_year?
		assert_equal(true, RDateTime::leap_year?(223))
		assert_equal(false, RDateTime::leap_year?(0))
		assert_equal(false, RDateTime::leap_year?(1))
		assert_equal(false, RDateTime::leap_year?(2))
		assert_equal(true, RDateTime::leap_year?(3))
	end



	def test_year_length
		assert_equal(366, RDateTime::year_length(223))
		assert_equal(365, RDateTime::year_length(0))
	end



	def test_rc_ajd

		assert_equal(0, @@rc_epoch.rc_ajd)
		assert_equal(1, (@@rc_epoch + 1).rc_ajd)
		assert_equal(1.5, (@@rc_epoch + 1.5).rc_ajd)
		assert_equal(1000, (@@rc_epoch + 1000).rc_ajd)
		n = @@rc_epoch.new_offset(Rational(5, 24))
		assert_equal(0, n.rc_ajd)

	end




	def test_rc_ajd_to_ajd

		assert_equal(RDateTime::RC_EPOCH.ajd, RDateTime::rc_ajd_to_ajd(0))
		assert_equal(RDateTime::RC_EPOCH.ajd + 1, RDateTime::rc_ajd_to_ajd(1))
		assert_equal(RDateTime::RC_EPOCH.ajd + 1.5, RDateTime::rc_ajd_to_ajd(1.5))

	end

	def test_from_ajd

		assert_equal(@@t, RDateTime::from_ajd(@@t.ajd))
		assert_equal(@@l, RDateTime::from_ajd(@@l.ajd))
		assert_equal(@@rc_epoch, RDateTime::from_ajd(@@rc_epoch.ajd))
		
		n = RDateTime::from_ajd(@@t.ajd).new_offset(@@t.offset)
		assert_equal(@@t, n)



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



	def test_prop_rc_year_to_past_days

		assert_equal(0, RDateTime::prop_rc_year_to_past_days(0))
		assert_equal(365, RDateTime::prop_rc_year_to_past_days(1))
		assert_equal(365 * 2, RDateTime::prop_rc_year_to_past_days(2))
		assert_equal(365 * 3, RDateTime::prop_rc_year_to_past_days(3))
		assert_equal(365 * 4 + 1, RDateTime::prop_rc_year_to_past_days(4))
		assert_equal(365 * 100 + 24, RDateTime::prop_rc_year_to_past_days(100))
		assert_equal(365 * 400 + (24 * 4) + 1, RDateTime::prop_rc_year_to_past_days(400))

	end



	def test_rc_ajd_to_prop_rc_year

		assert_equal(0, RDateTime::rc_ajd_to_prop_rc_year(100))
		assert_equal(0, RDateTime::rc_ajd_to_prop_rc_year(364))
		assert_equal(1, RDateTime::rc_ajd_to_prop_rc_year(365))
		assert_equal(1, RDateTime::rc_ajd_to_prop_rc_year(366))
		assert_equal(2, RDateTime::rc_ajd_to_prop_rc_year(1000))
		assert_equal(3, RDateTime::rc_ajd_to_prop_rc_year(365 + 365 + 365 + 365))
		assert_equal(4, RDateTime::rc_ajd_to_prop_rc_year(365 + 365 + 365 + 366))
		assert_equal(8, RDateTime::rc_ajd_to_prop_rc_year((365 + 365 + 365 + 366) * 2))
		assert_equal(400, RDateTime::rc_ajd_to_prop_rc_year(365 * 400 + 97))

	end

	def test_rc_ajd_to_prop_rc_year_candidates

		assert_equal([0, 1], RDateTime::rc_ajd_to_prop_rc_year_candidates(365))
		assert_equal([0, 1, 2], RDateTime::rc_ajd_to_prop_rc_year_candidates(366))
		assert_equal([1, 2, 3], RDateTime::rc_ajd_to_prop_rc_year_candidates(365 + 365 + 365))
		assert_equal([2, 3, 4], RDateTime::rc_ajd_to_prop_rc_year_candidates(365 * 4 ))
		assert_equal([3, 4, 5], RDateTime::rc_ajd_to_prop_rc_year_candidates(365 * 4 + 1))

	end



	def test_from_prop_rc

		assert_equal(@@rc_epoch, RDateTime::from_prop_rc(0, 0, 0, 0, 0, 0))
		assert_equal(@@rc_epoch + 3, RDateTime::from_prop_rc(0, 0, 3, 0, 0, 0))
		assert_equal(@@rc_epoch + 365, RDateTime::from_prop_rc(1, 0, 0, 0, 0, 0))
		assert_equal(@@rc_epoch + 365 * 4 + 1, RDateTime::from_prop_rc(4, 0, 0, 0, 0, 0))

	end



	def test_in_prop_rc_year?

		assert_equal(true, @@t.in_prop_rc_year?(223))
		assert_equal(true, @@l.in_prop_rc_year?(223))
		assert_equal(true, (@@l + 100).in_prop_rc_year?(224))

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



	def test_prop_rc_year_to_rc_ajd
		assert_equal(0, RDateTime::prop_rc_year_to_rc_ajd(0))
		assert_equal(365, RDateTime::prop_rc_year_to_rc_ajd(1))
		assert_equal(365 * 2, RDateTime::prop_rc_year_to_rc_ajd(2))
		assert_equal(365 * 3, RDateTime::prop_rc_year_to_rc_ajd(3))
		assert_equal(365 * 4 + 1, RDateTime::prop_rc_year_to_rc_ajd(4))
		assert_equal(365 * 5 + 1, RDateTime::prop_rc_year_to_rc_ajd(5))
	end


	def test_prop_rc_to_rc_ajd
		assert_equal(0, RDateTime::prop_rc_to_rc_ajd(0, 0, 0, 0, 0, 0))
		assert_equal(1, RDateTime::prop_rc_to_rc_ajd(0, 0, 1, 0, 0, 0))
		assert_equal(364, RDateTime::prop_rc_to_rc_ajd(0, 0, 364, 0, 0, 0))
		assert_equal(365, RDateTime::prop_rc_to_rc_ajd(1, 0, 0, 0, 0, 0))
		assert_equal(365 + 1, RDateTime::prop_rc_to_rc_ajd(1, 0, 1, 0, 0, 0))
		assert_equal(365 + 10, RDateTime::prop_rc_to_rc_ajd(1, 0, 10, 0, 0, 0))
		assert_equal(365 + 364, RDateTime::prop_rc_to_rc_ajd(1, 0, 364, 0, 0, 0))
		assert_equal(365 * 2, RDateTime::prop_rc_to_rc_ajd(2, 0, 0, 0, 0, 0))
		assert_equal(365 * 3, RDateTime::prop_rc_to_rc_ajd(3, 0, 0, 0, 0, 0))
		assert_equal(365 * 4 + 1, RDateTime::prop_rc_to_rc_ajd(4, 0, 0, 0, 0, 0))
		assert_equal(365 * 4 + 1 + 20 , RDateTime::prop_rc_to_rc_ajd(4, 0, 20, 0, 0, 0))
		assert_equal(365 * 4 + 1 + 20 + 0.5, RDateTime::prop_rc_to_rc_ajd(4, 0, 20, 5, 0, 0))
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



	def test_prop_rc_parse
		m = RDateTime.prop_rc_parse('223:333')
		n = RDateTime.new(2016, 8, 20, 8, 0, 0, Rational(9, 24)).new_offset(0)
		assert_equal(m, n)

		o = RDateTime.prop_rc_parse('223:333.5')
		p = RDateTime.new(2016, 8, 20, 20, 0, 0, Rational(9, 24)).new_offset(0)
		assert_equal(o, p)

		q = RDateTime.prop_rc_parse('223:')
		r = RDateTime.new(2015, 9, 22, 8, 0, 0, Rational(9, 24)).new_offset(0)
		assert_equal(q, r)

		s = RDateTime.prop_rc_parse(':333')
		t = RDateTime.new(RDateTime.now.year, 8, 20, 8, 0, 0, Rational(9, 24)).new_offset(0)
		assert_equal(s, t)
	end
end
