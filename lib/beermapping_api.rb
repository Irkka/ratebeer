class BeermappingAPI

		def self.places_in city
				Place
				city = city.downcase
				Rails.cache.write(city, { :places => fetch_places_in(city) }, expires_in: 1.hour) unless Rails.cache.exist? city
				#binding.pry
				Rails.cache.read(city)[:places]
		end

		private

		def self.fetch_places_in city
				url = "http://beermapping.com/webservice/loccity/#{key}/"
				response = HTTParty.get("#{url}#{city.gsub(' ', '%20')}")			
				places = response.parsed_response["bmp_locations"]["location"]

				return [] if places.is_a?(Hash) and places['id'].nil?

				places = [places] if places.is_a?(Hash)
				return places.inject [] do |set, place|
						set << Place.new(place)
				end
		end

		def self.fetch_place_score id
				url = "http://beermapping.com/webservice/locscore/#{key}/"
				response = HTTParty.get("#{url}#{id}")			
				#binding.pry
				response.parsed_response["bmp_locations"]["location"]
		end

		def self.key
				Settings.beermapping_apikey
		end
end
