module FrothyBeer
  
  module WebPage
    
    # Creates a new webpage from a url
    def self.getPage(url)
      open(url) {|f| Hpricot(f)}
    end
    
    def self.hasResults?(page)
      # are there elements with 'no results' as the text
      page.search("li[text()*='No results']").empty?
    end
    
    def self.getResults(page)
      return {} if !self.hasResults?(page)
      
      resultHash = {}
      list_elements = page.search("li/a")
      list_elements.each do |li|
        # Beer names are in bold. Alternate links are breweries
        if !li.at("b").nil?
          resultHash[li.at("b").html] = "http://beeradvocate.com#{li.get_attribute("href")}"
        end
      end
      
      resultHash
    end
    
  end # End of WebPage module
end