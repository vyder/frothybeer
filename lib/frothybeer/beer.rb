module FrothyBeer
  
  class Beer
    attr_reader :name, :brewery, :rating, :style, :abv
    
    # Beer hash params:
    # :name
    # :brewery
    # :rating
    # :style
    # :abv (alcohol by volume)
    def initialize(hash)
      @name = hash[:name]
      @brewery = hash[:brewery]
      @rating = hash[:rating]
      @style = hash[:style]
      @abv = hash[:abv]
    end
    
  end
  
end