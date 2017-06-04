require File.expand_path('../r_date_time.rb',  __FILE__)

origin = RDateTime.new(0, 1, 1)

result = (0 .. 40).to_a.map do |i|
	start = origin + i * 1000
	goal = origin + ( i + 1 ) * 1000
	[
		i * 1000,
		start.year,
		start.yday - 1
	]

end.map do |i|
	"#{i[0]} (#{i[1]}:#{i[2]})"
end

(0...result.size-1).each do |i|
	puts '# ' + result[i] + ' ... ' + result[i+1]
end
