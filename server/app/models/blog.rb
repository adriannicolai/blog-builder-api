include ApplicationHelper
class Blog < ApplicationRecord
	belongs_to :users

	# DOCU: Function to insert new vlog after creating a new user
	# Triggered by: UserModel
	# Requires: params - user_id
	# Last updated at: September 27, 2022
	# Owner: Adrian
	def self.create_blog(params)
		response_data = { :status => false, :result => {}, :error => nil }

		begin
			# Check blog parameters
			check_blog_parameters = check_fields([:user_id], [], params)

			raise "Missing required fields" if !check_blog_parameters[:status]

			create_blog_id = insert_record(["
				INSERT INTO blogs (user_id, name) VALUES(?, ?)
			", check_blog_parameters, "Untitled Blog" ])

		rescue Exception => ex
			response_data[:error] = ex.message
		end

		return response_data
	end
end
