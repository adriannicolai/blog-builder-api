class UserController < ApplicationController
	# DOCU: Function for user login
    # Triggered by: (POST) /user/register
	# Requires params - email, pasword
    # Last updated at: October 3, 2022
    # Owner: Adrian
	def login
		response_data = { :status => false, :result => {}, :error => nil }

		begin
			login_user = User.login_user(params)

			response_data.merge!(login_user)
		rescue Exception => ex
			response_data[:error] = ex.message
		end

		render :json => response_data
	end

	# DOCU: Function registering user
    # Triggered by: (POST) /user/register
	# Requires params - first_name, last_name, email, pasword, confirm_passsword
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
