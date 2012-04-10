$:.unshift File.dirname(__FILE__) # For use/testing when no gem is installed

# rubygems
require 'rubygems'

# 3rd party
require 'hpricot'
require 'open-uri'

# internal requires
require 'frothybeer/beer' # yarrr!
require 'frothybeer/webpage'
require 'frothybeer/version'



module FrothyBeer

  # Main search function used to find the beer
  #
  #
  def self.beersearch(beerToFind)
    return nil if beerToFind.nil? # TODO raise an exception
    
    # Clean query string
    query = beerToFind.gsub(" ", "+")
    url = "http://beeradvocate.com/search?q=#{query}&qt=beer"
    
    resultsPage = WebPage::getPage(url)
    if WebPage::hasResults?(resultsPage)
      results = WebPage::getResults(resultsPage)
    else
      # TODO raise an exception
      return []
    end

    # find the best match beers
    beer = nil
    suggestions = []
    results.each do |beer_name, beer_link|
      beer_page = WebPage::getPage(beer_link)
      b = Beer.new(self.makeBeerHash(beer_page))
      
      if beer_name == beerToFind # TODO Figure out a better matching algorithm
        beer = b
      else
        suggestions << b
      end
    end
    
    return suggestions.unshift(beer)
  end
  
  def self.makeBeerHash(page)
    hash = {}
    
    hash[:name] = self.scrapeName(page)
    hash[:brewery] = self.scrapeBrewery(page)
    hash[:rating] = self.scrapeRating(page)
    hash[:style] = self.scrapeStyle(page)
    hash[:abv] = self.scrapeABV(page)
    
    hash
  end
  
  # Methods to scrape the beer profile page.
  def self.scrapeName(page)
    page.search("h1[@class='norm']").html
  end
  
  def self.scrapeBrewery(page)
    page.search("a/b")[2].html
  end
  
  # Given a beer page, returns rating for the beer
  # (returns nil if rating N/A)
  def self.scrapeRating(page)
    rating = page.search("span[@class='BAscore_big']").first.html
    (rating == "N/A") ? nil : "#{rating}/100"
  end
  
  def self.scrapeStyle(page)
    page.search("a/b")[3].html
  end
  
  def self.scrapeABV(page)
    raw = page.search("a/b")[3].parent().next().inspect
    return nil if raw.match(/\?/) # There is no abv specified
    abv = raw.match(/([\d\.]*)%/)[0]
  end
  
end