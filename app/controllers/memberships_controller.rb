class MembershipsController < ApplicationController
		# GET /memberships
		# GET /memberships.json
		def index
				@memberships = Membership.all

				respond_to do |format|
						format.html # index.html.erb
						format.json { render json: @memberships }
				end
		end

		# GET /memberships/1
		# GET /memberships/1.json
		def show
				@membership = Membership.find(params[:id])

				respond_to do |format|
						format.html # show.html.erb
						format.json { render json: @membership }
				end
		end

		# GET /memberships/new
		# GET /memberships/new.json
		def new
				@membership = Membership.new
				@beer_clubs = BeerClub.all

				respond_to do |format|
						format.html # new.html.erb
						format.json { render json: @membership }
				end
		end

		# GET /memberships/1/edit
		def edit
				@membership = Membership.find(params[:id])
		end

		# POST /memberships
		# POST /memberships.json
		def create
				@beer_club = BeerClub.find_by_id params[:membership][:beer_club_id]
				redirect_to :back, notice: "No such beer club" if @beer_club.nil?
				raise CustomExceptions::AlreadyMemberException if @beer_club.users.include? current_user
				@membership = Membership.new(params[:membership])
				@membership[:user_id] = current_user.id

				@membership.save
				redirect_to memberships_path
				#respond_to do |format|
				#if @membership.save
				#format.html { redirect_to @membership, notice: 'Membership was successfully created.' }
				#format.json { render json: @membership, status: :created, location: @membership }
				#else
				#format.html { render action: "new" }
				#format.json { render json: @membership.errors, status: :unprocessable_entity }
				#end
				#end
		rescue CustomExceptions::AlreadyMemberException
				redirect_to :back, notice: 'Already a member!'
		rescue
				redirect_to :back, notice: 'Not logged in'
		end

		# PUT /memberships/1
		# PUT /memberships/1.json
		def update
				@membership           = Membership.find(params[:id])

				respond_to do |format|
						if @membership.update_attributes(params[:membership])
								format.html { redirect_to @membership, notice: 'Membership was successfully updated.' }
								format.json { head :no_content }
						else
								format.html { render action: "edit" }
								format.json { render json: @membership.errors, status: :unprocessable_entity }
						end
				end
		end

		# DELETE /memberships/1
		# DELETE /memberships/1.json
		def destroy
				@membership           = Membership.find(params[:id])
				@membership.destroy

				respond_to do |format|
						format.html { redirect_to memberships_url }
						format.json { head :no_content }
				end
		end
end
