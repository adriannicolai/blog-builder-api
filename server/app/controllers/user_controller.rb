include ApplicationHelper
include UserHelper

class UserController < ApplicationController
	def login
		response_data = { :status => false, :result => {}, :error => nil }

		begin

		rescue Exception => ex
			response_data[:error] = ex.message
		end

		render :json => response_data
	end

	# DOCU: API for registering user
    # Triggered by: (GET) /user/register
	# Session - POST
    # Last updated at: September 26, 2022
    # Owner: Adrian
	def register
		response_data = { :status => false, :result => {}, :error => nil}

		begin
			# Check for valid fields
			check_register_form_fields = check_fields(["email", "password", "confirm_password", "first_name", "last_name"], [], params)

			if check_register_form_fields[:status]
				# Proceed to registering the user if all fields are valid
				validate_new_user_info = validate_new_user_info(check_register_form_fields[:result])

				if validate_new_user_info[:status]
					# Create a new user
				else
					response_data.merge!(validate_new_user_info)
				end
			else
				response_data.merge!(check_register_form_fields)
			end
		rescue Exception => ex
			response_data[:error] = ex.message
		end

		render :json => response_data
	end

	def update_user
	end
end
