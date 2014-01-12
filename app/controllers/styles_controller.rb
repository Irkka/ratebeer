class StylesController < ApplicationController

		def index
		end

		def show
				@style = Style.find(params[:id])
		end
end
