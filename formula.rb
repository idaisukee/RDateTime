require File.expand_path('../r_date_time.rb',  __FILE__)
def y(n)

i =
	(
		Rational( 4 * ( n + 1 ) , 146097 )
	).floor
j = i + 1
k =
	(
		Rational(3, 4) * j
	).floor
l = 4 * k
a = 4 * n + 3 + l
y =
	(
		Rational(a, 1461)
	).floor
end

p y(364.4)
