require 'spec_helper'

describe "User" do
		include OwnTestHelper
		let!(:brewery) {FactoryGirl.create :brewery}
		let!(:user) {FactoryGirl.create :user}

		before :each do
				#FactoryGirl.create(:user)
		end

		describe "who has signed up" do
				before :each do
						visit signin_path
				end
				it "can sign in with right credentials" do
						visit '/signin'
						fill_in('username', :with => 'Jorma')
						fill_in('password', :with => 'Hello5')
						click_button('Log in')

						expect(page).to have_content 'Hello again'
						expect(page).to have_content 'Jorma'
				end

				it "is redirected back to sign in form if wrong credentials are given" do
						#visit '/signin'
						#fill_in 'username', :with => 'Torspo'
						#fill_in 'password', :with => '1'
						sign_in "Jorma", "1"
						click_button 'Log in'

						expect(current_path).to eq(signin_path)
						expect(page).to have_content 'Username and password don\'t match'
				end
		end
		it "when signed up with good credentials, is added to the system" do
				visit signup_path
				fill_in 'user_username', :with => "Torspo"
				fill_in 'user_password', :with => "secret55"
				fill_in 'user_password_confirmation', :with => "secret55"

				expect {
						click_button 'Create User'
				}.to change {User.count}.by(1)
		end

		it "can add a beer to the database" do
				expect {
				visit new_beer_path
				fill_in 'beer_name', :with => "Hello Beer"
				select 'Weizen', :from => "beer_style"
				select brewery.name, :from => "beer_brewery_id"
				click_button 'Create Beer'
				}.to change {Beer.count}.by(1)
		end

		it "shows the user's favorite beer and brewery at the user's page" do
				visit user_path user
				expect(page).to have_content "Favorite brewery: #{user.favorite_brewery}"
				expect(page).to have_content "Favorite beer: #{user.favorite_beer}"
		end
end
