require 'spec_helper'

describe "Beerlist page" do
		before :all do
				self.use_transactional_fixtures = false
				WebMock.disable_net_connect!(:allow_localhost => true)
		end
		before :each do
				DatabaseCleaner.strategy = :truncation
				DatabaseCleaner.start

				@brewery1 = FactoryGirl.create(:brewery, :name => "Koff")
				@brewery2 = FactoryGirl.create(:brewery, :name => "Hello")
				@brewery3 = FactoryGirl.create(:brewery, :name => "Brewery")
				@style1 = Style.create :name => "Lager"
				@style2 = Style.create :name => "Ale"
				@style3 = Style.create :name => "Rauchbier"
				@beer1 = FactoryGirl.create(:beer, :name => "Nikolai", :brewery => @brewery1, :style => @style1)
				@beer2 = FactoryGirl.create(:beer, :name => "Fastenbier", :brewery => @brewery2, :style => @style2)
				@beer3 = FactoryGirl.create(:beer, :name => "Lechte WeiBe", :brewery => @brewery3, :style => @style3)
		end

		after :each do
				DatabaseCleaner.clean
		end

		after :all do
				self.use_transactional_fixtures = true
		end

		it "shows one known beer", :js => true do
				visit beerlist_path
				find('table').find('tr:nth-child(2)')
				save_and_open_page
				expect(page).to have_content "Nikolai"
		end

		#it "should have the beers ordered by name by default" do
				#visit beerlist_path
				#find('table').find('tr:nth-child(2)').should have_content('Fastenbier')
				#save_and_open_page
		#end
end
