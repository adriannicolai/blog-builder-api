class BlogController < ApplicationController
	# DOCU: Function for user login
    # Triggered by: (POST) /user/register
	# Requires: params - blog_id
    # Last updated at: September 27, 2022
    # Owner: Adrian
	def view_blog
		response_data = { :status => false, :result => {}, :error => nil }

		begin
			blog_details = Blog.get_blog_data(params)

			response_data.merge!(blog_details)
		rescue Exception => ex
			response_data[:error] = ex.message
		end

		render :json => response_data
	end

	def update_blog
	end
end
