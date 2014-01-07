require 'spec_helper'

describe Beer do
		let(:brewery) { Brewery.create name: "Hello Brewery", year: 1900 }
		let(:beer) { FactoryGirl.create(:testing_beer, :name => "Hello?") }
		describe "is not saved" do

				it "when beer has no name" do
						test_beer = Beer.new
						test_beer.brewery = brewery
						expect(test_beer.valid?).to be(false)
						Beer.all << test_beer
						Beer.count.should.equal? 0
				end
				it "when beer has no style specified" do
						test_beer = Beer.new
						test_beer.name = "Hello Beer"
						test_beer.brewery = brewery
						expect(test_beer.valid?).to be(false)
						#Beer.all << test_beer
						test_beer.save
						Beer.count.should.equal? 0
				end
		end

		describe "is saved" do
				it "when beer has a name, style and a brewery" do
						#test_beer.brewery = brewery
						#test_beer.style = "Good Beer"
						#test_beer.name = "Hello Beer"
						expect(beer.valid?).to be(true)

						Beer.all << beer
						Beer.count.should.equal? 1
				end
		end
end
