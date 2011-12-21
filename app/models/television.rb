class Television < ActiveRecord::Base
  validates_uniqueness_of :model

  # Gather Televisions from Walmart based on a search with the given term.
  #
  # term: string
  #
  # Returns an array of Televisions
  def self.from_walmart(term)
    tvs = []

    @agent ||= Mechanize.new

    @agent.get "http://www.walmart.com/search/search-ng.do?search_query=#{term}"

    # All Televisions on the Walmart website are displayed with the 'item' class.
    @agent.page.search('.item').each do |item|
      item_name = item.search('.ListItemLink').text.strip
      model = item.search('.ModelNo').text.gsub(/Model#:/, '').strip
      price = 0.0

      begin
        price = item.search('.camelPrice').first.text.strip.delete('$,').to_f
      rescue
        # In some cases they do not display a price until checkout.  In that case,
        # we can just grab the list price (which is not the actual price, but
        # close enough).
        price = item.search('.PriceSItalicStrikethruLtgry').text.delete('$,').to_f
      end

      rating = item.search('.CustomerRatingStars').search('img').attr('alt').value rescue "Unknown"

      tvs << self.find_or_create_by_model(model) do |tv|
        tv.name = item_name
        tv.price = price
        tv.rating = rating
      end
    end

    tvs
  end
end
