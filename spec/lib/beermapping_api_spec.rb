require 'spec_helper'

describe "BeermappingAPI" do
		it "When HTTP GET returns one entry, it is parsed and returned" do
				s = <<-END_OF_STRING
<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>13307</id><name>O'Connell's Irish Bar</name><status>Beer Bar</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=13307</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=13307&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=13307&amp;d=1&amp;type=norm</blogmap><street>Rautatienkatu 24</street><city>Tampere</city><state></state><zip>33100</zip><country>Finland</country><phone>35832227032</phone><overall>0</overall><imagecount>0</imagecount></location></bmp_locations>
				END_OF_STRING

				stub_request(:get, /.*/).to_return(:body => s, :headers => { 'Content-Type' => "text/xml"})

				places = BeermappingAPI.places_in("tampere")

				expect(places.size).to eq(1)
				place = places.first
				expect(place.name).to eq("O'Connell's Irish Bar")
				expect(place.street).to eq("Rautatienkatu 24")
		end
end
