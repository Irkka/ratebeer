class PlacesController < ApplicationController

		def index
		end

		def show
				#binding.pry
				last_searched_city = session[:last_searched_city]
				if Rails.cache.read(last_searched_city).nil?
						redirect_to places_path, :notice => "Cache has expired"
				else
						@place = Rails.cache.read(last_searched_city)[:places].select{|place| place.id == params[:id]}.first
						@score = BeermappingAPI.fetch_place_score params[:id]
				end
				#binding.pry
		end

		def search
				city = params[:city]
				if city == ""
						redirect_to places_path, :notice => "Enter a valid city"
				else
						session[:last_searched_city] = city
						@places = BeermappingAPI.places_in(city)
						if @places.empty?
								redirect_to places_path, :notice => "No locations in #{city}"
						else
								render :index
						end
				end
		end
end
