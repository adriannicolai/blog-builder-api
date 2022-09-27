class BlogTitleController < ApplicationController
	# DOCU: Function for creating blog_title
    # Triggered by: (POST) /blog_title/create_blog_title
    # Last updated at: September 27, 2022
    # Owner: Adrian
	def create_blog_title
		response_data = { :status => false, :result => {}, :error => nil }

		begin
			create_blog_title = BlogTitle.create_blog_title(params)

			response_data.merge!(create_blog_title)
		rescue Exception => ex
			response_data[:error] = ex.message
		end

		render :json => response_data
	end

	def update_blog_title

	end
end
