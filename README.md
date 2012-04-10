# Frothybeer

Gets ratings, styles, abv content, breweries, and other information from a beer's name

Very simple and crude at the moment. Needs an exact match to the name to find the beer. However, it does return an array of other matches as a result. (The first element is the exact match, or 'nil' if an exact match was not found)

## Installation

Add this line to your application's Gemfile:

    gem 'frothybeer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install frothybeer

## Usage

test.rb:

	require './frothybeer/lib/frothybeer'

	exit if ARGV[0].nil?

	beers = FrothyBeer::beersearch(ARGV[0])
	if beers.empty?
		puts "No results found for that beer"
	elsif beers.first.nil?
	puts "Did not find #{ARGV[0]}, but we did find these similarly named beers:"
	beers.shift
	beers.each do |beer|
		puts "#{beer.name} with a rating of #{beer.rating}" if !beer.rating.nil?
	end
	else
		beer = beers.first
	puts "#{beer.name} has a rating of #{beer.rating}"
	end

Sample output:

	$ ruby test.rb "Sierra Nevada Pale Ale"
	Sierra Nevada Pale Ale has a rating of 91/100
	$ ruby test.rb "Anchor Steam"
	Did not find Anchor Steam, but we did find these similarly named beers:
	Anchor Steam Beer with a rating of 87/100
	$ ruby test.rb "asdgaga"
	No results found for that beer
	$ ruby test.rb "Belgian Ale"
	Did not find Belgian Ale, but we did find these similarly named beers:
	Borman's Belgian Ale with a rating of 78/100
	Friar's Belgian-Style White Ale with a rating of 82/100
	W'09 Belgian Style Ale with a rating of 82/100

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
