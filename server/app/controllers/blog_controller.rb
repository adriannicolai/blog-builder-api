class BlogController < ApplicationController
	# DOCU: Function for fetching blogs
    # Triggered by: (GET) /blog/view_blog
	# Requires: params - blog_id
    # Last updated at: September 29, 2022
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
