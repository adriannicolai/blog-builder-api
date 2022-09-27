include ApplicationHelper
include QueryHelper

class BlogTitle < ApplicationRecord
	belongs_to :blogs

	def self.create_blog_title(params)
		response_data = { :status => false, :result => {}, :error => nil }

		begin
			# Check blog_title_parameters
			check_blog_title_parameters = check_fields(["blog_id", "name"], [], params)

			# Guard clase for check_blog_title_parameters
			raise check_blog_title_parameters[:error] if !check_blog_title_parameters[:status]

			# Destructure check_blog_title_parameters
			blog_id, name = check_blog_title_parameters[:result].values_at(:blog_id, :name)

			# Check if the blog id is valid
			blog_record = Blog.get_blog_record({ :fields_to_filter =>{ :id => blog_id }})

			if blog_record[:status]
				created_blog_title_id = insert_record(["
					INSERT INTO blog_titles (blog_id, name, created_at, updated_at) VALUES(?, ?, NOW(), NOW())
				", blog_id, name])

				blog_title_record = self.get_user_blog_title({ :fields_to_filter => { :id => created_blog_title_id }})

				response_data.merge!(blog_title_record)
			else
				response_data[:error] = "Failed to create blog title, Please try again later."
			end
		rescue Exception => ex
			response_data[:error] = ex.message
		end

		return response_data
	end

	# DOCU: Function to fetch blog_title record dynamically
	# Triggered by: UserModel
	# Requires: params - fields_to_filter
	## Optionals: params - fields_to_select
	# Last updated at: September 27, 2022
	# Owner: Adrian
	private
		def self.get_user_blog_title(params)
			response_data = { :status => false, :result => {}, :error => nil }

			begin
				params[:fields_to_select] ||= "*"

				select_blog_query = ["
					SELECT #{ActiveRecord::Base.sanitize_sql(params[:fields_to_select])}
					FROM blog_titles WHERE
				"]

				params[:fields_to_filter].each_with_index do |(field, value), index|
					select_blog_query[0] += " #{'AND' if index > 0} #{field} #{field.is_a?(Array) ? 'IN(?)' : '=?'}"
					select_blog_query    << value
				end

				# Query the blog record
				blog_record = query_record(select_blog_query)

				response_data.merge!(blog_record.present? ? { :status => true, :result => blog_record } : { :error => "Error in fetching blog title record data, Please try again later." })
			rescue Exception => ex
				response_data[:error] = ex.message
			end

			return response_data
		end
end
