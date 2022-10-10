class BlogTitleController < ApplicationController
	# DOCU: Function for fetching blog_title with content blog_title
    # Triggered by: (GET) /blog_title/get_blog_tittle
	# Requires params - blog_title_id
    # Last updated at: October 10, 2022
    # Owner: Adrian
	def get_blog_title_contents
		response_data = { :status => false, :result => {}, :error => nil }

		begin
			get_blog_title = BlogTitle.get_blog_title_contents(params)

			response_data.merge!(get_blog_title)
		rescue Exception => ex
			response_data[:error] = ex.message
		end

		render :json => response_data
	end

	# DOCU: Function for creating blog_title
    # Triggered by: (POST) /blog_title/create_blog_title
	# Requires params - blog_id, name
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

	# DOCU: Function for updating blog_title
    # Triggered by: (POST) /blog_title/update_blog_title
	# Requires params - blog_id, name
    # Last updated at: September 28, 2022
    # Owner: Adrian
	def update_blog_title
		response_data = { :status => false, :result => {}, :error => nil }

		begin
			update_blog_title = BlogTitle.update_blog_title(params)

			response_data.merge!(update_blog_title)
		rescue Exception => ex
			response_data[:error] = ex.message
		end

		render :json => response_data
	end

	# DOCU: Function for fetching all toe blog titles
    # Triggered by: (GET) /blog_title/update_blog_ti
	# Requires params - blog_id, name
    # Last updated at: October 10, 2022
    # Owner: Adrian
	def get_blog_titles
		response_data = { :status => false, :result => {}, :error => nil }

		begin
			blog_titles = BlogTitle.get_blog_titles(params)

			response_data.merge!(blog_titles)
		rescue Exception => ex
			response_data[:error] = ex.message
		end

		render :json => response_data
	end
end
