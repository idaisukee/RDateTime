require (ENV['SRC']+"/rdatetime/r_date_time")
require (ENV['SRC']+"/rdatetime/float")

line = STDIN.gets.strip
array = line.split(',')

print '|'
print array[0]
print '|'
print array[1]

items = array[2..3]
items.each do |item|
	print '|'
	print item
	print '|'
	print RDateTime::time_conv_g_pr(item).to_f.to_s[1..4]
end
print '|'
print "\n"

