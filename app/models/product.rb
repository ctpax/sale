class Product < ActiveRecord::Base
  belongs_to :list

  def self.party(search, limit, category)

		limit ||= 20

		auth = { query: { pid: 'uid4689-25055367-8', limit: limit, fl: 'd', sort: 'recency', fts: search}} # Adds to end of URL ?apikey=<YOURKEY>&q=<MOVIE>
		search_url = "http://api.shopstyle.com/api/v2/products"
		
		response = HTTParty.get search_url, auth

		response.parsed_response["products"]
	end
end
