require 'factory_girl'

FactoryGirl.define do
		factory :user do
				username "Jorma"
				password "Hello5"
				password_confirmation "Hello5"
		end

		factory :rating do
		end

		factory :rating1, :class => Rating do
				score 10
		end

		factory :rating2, :class => Rating do
				score 50
		end

		factory :brewery do
				name "anonymous"
				year 1900
		end

		factory :beer do
				name "anonymous"
				brewery
				style Style.new :name => "Beer Perkele"
		end

		factory :testing_beer, :class => Beer do
				brewery
				style Style.new :name => "Ale"
		end

end
