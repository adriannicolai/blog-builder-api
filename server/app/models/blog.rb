include ApplicationHelper
class Blog < ApplicationRecord
	belongs_to :users

	# DOCU: Function to insert new blog after creating a new user
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

			created_blog_id = insert_record(["
				INSERT INTO blogs (user_id, name, created_at, updated_at) VALUES(?, ?, NOW(), NOW())
			", check_blog_parameters[:result][:user_id], "Untitled Blog" ])

			# TODO: Add encryption of blog details and user details
			blog_record = self.get_blog_record({ :fields_to_filter => { :id => created_blog_id }})

			response_data.merge!(blog_record)
		rescue Exception => ex
			response_data[:error] = ex.message
		end

		return response_data
	end

	# DOCU: Function to show the blog data titles
	# Triggered by: BlogController
	# Requires: params - blog_id
	# Last updated at: September 29, 2022
	# Owner: Adrian
	def self.get_blog_data(params)
		response_data = { :status => false, :result => {} , :error => nil }

		begin
			# Check fields for user data
			check_blog_parameters = check_fields(["blog_id"], [], params)

			# Guard clause for blog parameters
			raise check_blog_parameters[:error] if !check_blog_parameters[:status]

			# Desctructure check_blog_parameters
			blog_id = check_blog_parameters[:result].values_at(:blog_id)

			blog_record = query_records(["
				SELECT blog_titles.id, blog_titles.name FROM blogpost.blogs
				INNER JOIN blog_titles ON blog_titles.blog_id = blogs.id
				WHERE blog_id = ?
			", blog_id ])

			response_data.merge!(blog_record.present? ? { :status => true, :result => blog_record } : { :error => "Error in fetching blog_record" })
		rescue Exception => ex
			response_data[:error] = ex.message
		end

		return response_data
	end

	# DOCU: Function to fetch blog record dynamically
	# Triggered by: UserModel
	# Requires: params - fields_to_filter
	# Optionals: params - fields_to_select
	# Last updated at: September 27, 2022
	# Owner: Adrian
	private
		def self.get_blog_record(params)
			response_data = { :status => false, :result => {}, :error => nil }

			begin
				params[:fields_to_select] ||= "*"

				select_blog_query = ["
					SELECT #{ActiveRecord::Base.sanitize_sql(params[:fields_to_select])}
					FROM blogs WHERE
				"]

				params[:fields_to_filter].each_with_index do |(field, value), index|
					select_blog_query[0] += " #{'AND' if index > 0} #{field} #{field.is_a?(Array) ? 'IN(?)' : '=?'}"
					select_blog_query    << value
				end

				# Query the blog record
				blog_record = query_record(select_blog_query)

				response_data.merge!(blog_record.present? ? { :status => true, :result => blog_record } : { :error => "Error in fetching blog record data, Please try again later." })
			rescue Exception => ex
				response_data[:error] = ex.message
			end

			return response_data
		end
end
