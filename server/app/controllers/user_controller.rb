class UserController < ApplicationController
	# DOCU: Function for user login
    # Triggered by: (POST) /user/register
    # Last updated at: September 27, 2022
    # Owner: Adrian
	def login
		response_data = { :status => false, :result => {}, :error => nil }

		begin

		rescue Exception => ex
			response_data[:error] = ex.message
		end

		render :json => response_data
	end

	# DOCU: Function registering user
    # Triggered by: (POST) /user/register
    # Last updated at: September 27, 2022
    # Owner: Adrian
	def register
		response_data = { :status => false, :result => {}, :error => nil}

		begin
			create_new_user = User.create_new_user(params)

			response_data.merge!(create_new_user)
		rescue Exception => ex
			response_data[:error] = ex.message
		end

		render :json => response_data
	end

	def update_user
	end
end
