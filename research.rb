# -*- coding: utf-8 -*-
require 'date'

# Tokyo afternoon
ta = DateTime.new(2016, 6, 21, 14, 30, 00, Rational(9, 24))

# London morning
lm = DateTime.new(2016, 6, 21, 5, 30, 00, Rational(0, 24))

# London afternoon
la = DateTime.new(2016, 6, 21, 14, 30, 00, Rational(0, 24))

p ta.ajd, lm.ajd, la.ajd
p ta.ajd == lm.ajd # => true . 同じ時点ならば ajd は等しい．

p ta.jd, lm.jd, la.jd # 2457561
p ta.jd == lm.jd # =>true
p lm.jd == la.jd # => true. jd は時刻の情報を持たない．

# London today
lt = DateTime.new(2016, 6, 21, 0, 30, 00, Rational(0, 24))

# London yesterday
ly = DateTime.new(2016, 6, 20, 23, 30, 00, Rational(0, 24))

p lt.jd == ly.jd # => false


p la.ajd - lm.ajd # => 3/8 . 1 日の 3/8 だけの時間差．
p ta.ajd - lm.ajd # => 0
p ta.ajd - la.ajd # => -3/8 .

d1 = DateTime.jd(2457561)
p d1.to_s # => 2016-06-21T00:00:00+00:00 . 標準では UTC .

d2 = DateTime.jd(2457561.5)
p d2.to_s # => 2016-06-21T12:00:00+00:00 . jd の引数は小数部分も解釈される．

d3 = DateTime.jd(2457561, 3, 40, 0) 
p d3.to_s # => 2016-06-21T03:40:00+00:00 . 引数で時刻を指定するときは， jd は整数でなければならない．

d4 = DateTime.jd(2457561, 3, 40, 0, Rational(9, 24)) 
p d4.to_s # => 2016-06-21T03:40:00+09:00

p d3.ajd, d4.ajd
p d3.ajd == d4.ajd # => false . 時刻が同じでも時点が違うので false となる．

d5 = DateTime.new(2016, 2, 2, 0, 0, 0, Rational(0, 24))
p d5.ajd, d5.jd
p d5.ajd - d5.jd # => -1/2 . UTC の地域で， ajd は jd より 1/2 だけ遅れている．

d6 = DateTime.new(2016, 2, 2, 0, 0, 0, Rational(9, 24))
p d6.ajd, d6.jd
p d6.ajd - d6.jd # => -7/8
p d6.ajd - d6.jd - Rational(-1, 2) # => -3/8 . UTC でない地域では， 1/2 + ( 時差 ) の分だけ ajd は jd より遅れている．

t1 = DateTime.new(2016, 4, 27, 6, 0, 0, Rational(9, 24))
t2 = DateTime.new(2016, 4, 27, 10, 0, 0, Rational(9, 24))

p t1.jd, t2.jd
p t1.jd == t2.jd

t3 = DateTime.new(2016, 4, 27, 6, 0, 0, Rational(9, 24))
t4 = DateTime.new(2016, 4, 27, 23, 0, 0, Rational(9, 24))

p t3.jd, t4.jd
p t3.jd == t4.jd
