include ApplicationHelper
include QueryHelper
class BlogContent < ApplicationRecord
    belongs_to :blogs
    belongs_to :blog_titles

    def self.create_blog_title_content(params)
      	response_data = { :status => false, :result => {}, :error => nil }

		begin
			# Check fields for create_blog_title_content
			check_create_blog_title_content_parameters = check_fields([:blog_id, :blog_title_id], [:content], params)

			# Guard clause for check_create_blog_title_content_parameters
			raise check_create_blog_title_content_parameters[:error] if !check_create_blog_title_content_parameters[:status]

			# Destructure check_create_blog_title_content_parameters
			blog_id, blog_title_id = check_create_blog_title_content_parameters[:result].values_at(:blog_id, :blog_title_id)

			# Check if the blog and blog_title is existing
			blog_record 	  = Blog.get_blog_record({ :fields_to_filter => { :id => blog_id }})
			blog_title_record = BlogTitle.get_blog_title_record({ :fields_to_filter => { :id => blog_title_id }})

			# Guard clause for checking blog_title and blog record
			raise "Error in creating blog title, Please try again later." if !blog_record[:status] || !blog_title_record[:status]

			# Create the blog_title_content
			created_blog_title_content_id = insert_record(["
				INSERT INTO blog_contents (blog_id, blog_title_id, content, created_at, updated_at) VALUES(?, ?, ?, NOW(), NOW())
			", blog_id, blog_title_id, ""])

		rescue Exception => ex
			response_data[:error] = ex.message
		end

		return response_data
    end
end
