require File.expand_path('../r_date_time.rb',  __FILE__)
require File.expand_path('../float.rb',  __FILE__)

require 'optparse'

available_opts = 'i:y:m:d:'
# i stands for increment.
params = ARGV.getopts(available_opts)

now = RDateTime.now
increment = params['i'].to_f

year = ( params['y'] || now.year).to_i
month = ( params['m'] || now.month ).to_i
day = ( params['d'] || now.day ).to_i

out = RDateTime.new(year, month, day, now.hour, now.min, now.sec, now.offset) + increment

puts out

