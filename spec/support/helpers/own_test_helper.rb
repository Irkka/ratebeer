module OwnTestHelper
		def sign_in username, password
				visit signin_path
				fill_in 'username', :with => username
				fill_in 'password', :with => password
				click_button 'Log in'
		end
end
