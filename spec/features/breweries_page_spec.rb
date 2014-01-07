require 'spec_helper'

describe "Breweries page" do
		it "should not have any before been created" do
				visit breweries_path
				#save_and_open_page
				expect(page).to have_content "Listing breweries"
				expect(page).to have_content "Number of breweries"
		end

		describe "when breweries exist" do
				before :each do
						@breweries = ["Koff", "Hello Brewery", "Tuupovaara"]
						year = 1896
						@breweries.each do |brewery|
								FactoryGirl.create(:brewery, :name => brewery, :year => year += 1)
						end
				end

				it "lists the existing breweries and their total number" do
						visit breweries_path

						expect(page).to have_content "Number of breweries: #{@breweries.count}"

						@breweries.each do |b|
								expect(page).to have_content b
						end
				end

				it "allows user to navigate to page of a Brewery" do
						visit breweries_path

						click_link "Koff"

						expect(page).to have_content "Koff"
						expect(page).to have_content "Year: 1897"
				end
		end
end
