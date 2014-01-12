require 'spec_helper'
require 'pry'

describe User do
		let(:user) { FactoryGirl.create(:user) }
		let(:brewery) { FactoryGirl.create(:brewery)}
		let(:brewery2) {FactoryGirl.create(:brewery, :name => "Test Brewery")}
		#let(:beer0) { FactoryGirl.create(:beer)}
		let(:beer) { FactoryGirl.create(:testing_beer, :name => "Hello Beer?")}
		let(:style) { Style.new :name => "Hell of a beer"}
		let(:style2) { Style.new :name => "Good Beer of a beer"}
		#let(:rating1){ FactoryGirl.create(:rating, :beer => beer1, :score => 10, :user => user)}
		#let(:rating2) { FactoryGirl.create(:rating, :beer => beer2, :score => 34, :user => user)}
		#let(:rating3) { FactoryGirl.create(:rating, :beer => beer3, :score => 20, :user => user)}

		it "has the username set correctly" do
				user = User.new username: "Jorma"
				user.username.should == "Jorma"
		end

		describe "favorite beer" do

				it "has method for determining one" do
						user.should respond_to :favorite_beer
				end

				it "without ratings does not have one" do
						expect(user.favorite_beer).to equal(nil)
				end

				it "is the only rated one, if other ratings don't exist" do
						rating = FactoryGirl.create(:rating2, :beer => beer, :user => user)

						expect(user.favorite_beer).to eq(beer)
				end

				it "is the one with highest rating if several ratings exist" do
						#beer1 = Beer.new( { :name => "Perkele", :style => "Hell of a beer" } )
						beer1 = Beer.new( { name:"Perkele"} )
						beer1.style = style
						beer1.brewery = brewery
						beer1.save
						beer2 = Beer.new( { name:"Ahti"} )
						beer2.style = style
						beer2.brewery = brewery
						beer2.save
						beer3 = Beer.new( { name:"Saatana" } )
						beer3.style = style
						beer3.brewery = brewery
						beer3.save
						rating1 = Rating.new( { score:30 } )
						rating2 = Rating.new( { score:40 } )
						rating3 = Rating.new( { score:20 } )
						rating1.beer = beer1
						rating2.beer = beer2
						rating3.beer = beer3
						#rating4.beer = beer0
						user.ratings << rating1
						user.ratings << rating2
						user.ratings << rating3
						#user.ratings << rating4
						#binding.pry
						expect(user.favorite_beer).to eq(beer2)
				end
		end

		describe "favorite style" do
				it "is the one with best average ratings" do
						#beer1 = Beer.new( { :name => "Perkele", :style => "Hell of a beer" } )
						beer1 = Beer.new( { name:"Perkele" } )
						beer1.style = style
						beer1.brewery = brewery
						beer1.save
						#beer2 = Beer.new( { name:"Ahti", :style => "Hell of a beer"} )
						beer2 = Beer.new( { name:"Ahti" } )
						beer2.style = style
						beer2.brewery = brewery
						beer2.save
						#beer3 = Beer.new( { name:"Saatana", :style => "Good Beer" } )
						beer3 = Beer.new( { name:"Saatana" } )
						beer3.style = style2
						beer3.brewery = brewery
						beer3.save
						rating1 = Rating.new( { score:30 } )
						rating2 = Rating.new( { score:40 } )
						rating3 = Rating.new( { score:20 } )
						rating1.beer = beer1
						rating2.beer = beer2
						rating3.beer = beer3
						user.ratings << rating1
						user.ratings << rating2
						user.ratings << rating3

						expect(user.favorite_style).to eq("Hell of a beer")
				end
		end

		describe "favorite brewery" do
				it "is the one with best average ratings" do
						#beer1 = Beer.new( { :name => "Perkele", :style => "Hell of a beer" } )
						beer1 = Beer.new( { name:"Perkele" } )
						beer1.style = style
						beer1.brewery = brewery
						beer1.save
						#beer2 = Beer.new( { name:"Ahti", :style => "Hell of a beer"} )
						beer2 = Beer.new( { name:"Ahti" } )
						beer2.style = style
						beer2.brewery = brewery2
						beer2.save
						#beer3 = Beer.new( { name:"Saatana", :style => "Good Beer" } )
						beer3 = Beer.new( { name:"Saatana" } )
						beer3.style = style2
						beer3.brewery = brewery
						beer3.save
						rating1 = Rating.new( { score:30 } )
						rating2 = Rating.new( { score:40 } )
						rating3 = Rating.new( { score:20 } )
						rating1.beer = beer1
						rating2.beer = beer2
						rating3.beer = beer3
						user.ratings << rating1
						user.ratings << rating2
						user.ratings << rating3

						expect(user.favorite_brewery).to eq("Test Brewery")
				end
		end

		describe "is not saved" do
				it "with password that's too short" do
						user = User.create username: "Jorma", password: "H5", password_confirmation: "H5"
						expect(user.valid?).to be(false)
						expect(User.count).to eq(0)
				end
				it "with password that doesn't contain a non-letter character" do
						user = User.create username: "Jorma", password: "onlylettershere", password_confirmation: "onlylettershere"
						expect(user.valid?).to be(false)
						expect(User.count).to eq(0)
				end
				it "without an existing password" do
						user = User.create username: "Jorma"
						expect(user.valid?).to be(false)
						expect(User.count).to eq(0)
				end
		end

		describe "with proper password" do
				let(:user) { FactoryGirl.create(:user) }

				it "is saved" do
						expect(user.valid?).to be(true)
						expect(User.count).to be(1)
				end

				it "and with two ratings has the correct average rating" do
						user = User.create username: "Jorma", password: "Hello5", password_confirmation: "Hello5"
						rating1 = FactoryGirl.create(:rating1)
						rating2 = FactoryGirl.create(:rating2)

						user.ratings << rating1
						user.ratings << rating2

						expect(user.ratings.count).to eq(2)
						expect(user.average_rating).to eq(30)
				end
		end

end
