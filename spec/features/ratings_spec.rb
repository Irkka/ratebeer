require 'spec_helper'

describe "Rating" do
		include OwnTestHelper

		let!(:brewery) { FactoryGirl.create :brewery, :name => "Koff" }
		let!(:beer1) { FactoryGirl.create :beer, :name => "iso 3", :brewery => brewery }
		let!(:beer2) { FactoryGirl.create :beer, :name => "Karhu", :brewery => brewery }
		let!(:user) { FactoryGirl.create :user }	

		before :each do
				#visit signin_path
				#fill_in('username', :with => 'Jorma')
				#fill_in('password', :with => 'Hello5')
				#click_button('Log in')
				sign_in "Jorma", "Hello5"
		end

		it "when given, is registered to the beer and user who is signed in" do
				visit new_rating_path
				select beer1.to_s, :from => 'rating[beer_id]'
				fill_in 'rating[score]', :with => '15'

				expect {
						click_button 'Create Rating'
				}.to change {Rating.count}.from(0).to(1)

				expect(user.ratings.count).to eq(1)
				expect(beer1.ratings.count).to eq(1)
				expect(beer1.average_rating).to eq(15.0)
		end

		it "instances are shown on the ratings page" do
				ratings = Rating.all
				visit ratings_path

				ratings.each do |r|
						expect(page).to have_content(r)
				end
		end

		it "instances that are user specific are show on the corresponding user page" do
				visit user_path user
				user.ratings.each do |r|
						expect(page).to have_content(r)
				end
		end

		it "is deleted, it is removed from the database" do
				rating = FactoryGirl.create(:rating, :score => 40)
				user.ratings << rating
				beer1.ratings << rating
				expect {
						visit user_path user
						click_link 'Delete'
				}.to change{user.ratings.count}.by(-1)
		end

end
