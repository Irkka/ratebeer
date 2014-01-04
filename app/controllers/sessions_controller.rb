class SessionsController < ApplicationController
		def new
		end

		def create
				user = User.find_by_username params[:username]
				if user.nil? or not user.authenticate params[:password]
						redirect_to :back, notice: "Username and password don't match"
				else
						session["user_id"] = user.id
						redirect_to user, notice: "Hello again"
				end
				#session[:user_id] = user.id if not user.nil? and user.authenticate params[:password]
		#rescue
				#redirect_to :back, :notice => "User #{params[:username]} does not exist, or password was incorrect"
		end

		def destroy
				session[:user_id] = nil
				redirect_to :root
		end
end
