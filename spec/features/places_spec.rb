require 'spec_helper'

describe "Places" do
		it "if one is retured by the API, it is shown on the page" do
				BeermappingAPI.stub(:places_in).with("kumpula").and_return([Place.new(:name => "Oljenkorsi")])

				visit places_path
				fill_in('city', :with => "kumpula")
				click_button "Search"

				expect(page).to have_content "Oljenkorsi"
		end

		it "if multiple places are returned, they're all shown on the page" do
				bars = [Place.new(:name => "Hello Bar"), Place.new(:name => "Janoinen Villisika")]
				BeermappingAPI.stub(:places_in).with("hello town").and_return(bars)

				visit places_path
				fill_in('city', :with => "hello town")
				click_button "Search"

				bars.each do |bar|
						expect(page).to have_content bar.name
				end
		end

		it "if none are returned, show 'No locations message' on index page" do
				BeermappingAPI.stub(:places_in).with("silent hill").and_return([])

				visit places_path
				fill_in('city', :with => "silent hill")
				click_button "Search"

				expect(page).to have_content "No locations in silent hill"
		end
end
