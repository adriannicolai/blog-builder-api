include ApplicationHelper
include QueryHelper
class BlogContent < ApplicationRecord
    belongs_to :blogs
    belongs_to :blog_titles

	# DOCU: Function to Create blog title content
	# Triggered by: BlogTitleModel
	# Requires: params - blog_id, blog_title_id
	# Last updated at: September 27, 2022
	# Owner: Adrian
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

			if created_blog_title_content_id.present?
				response_data.merge!(self.get_blog_content_record({ :fields_to_filter => { :id => created_blog_title_content_id }}))
			else
				raise "Error in creating blog_content_record, Please try again later."
			end

		rescue Exception => ex
			response_data[:error] = ex.message
		end

		return response_data
    end

	# DOCU: Function to update blog title content
	# Triggered by: BlogContentController
	# Requires: params - blog_id, content
	# Last updated at: September 28, 2022
	# Owner: Adrian
	def self.update_blog_content(params)
		response_data = { :status => false, :result => {}, :error => nil }

		begin
			# Check parameters before updating
			check_blog_content_parameters = check_fields(["blog_id", "content"], [], params)

			# Guard clause for check_blog_content_parameters
			raise check_blog_content_parameters[:error] if !check_blog_content_parameters[:status]

			# Destructure check_blog_content_parameters
			blog_id, content = check_blog_content_parameters[:result].values_at(:blog_id, :content)

			# Check if the blog content is existing
			blog_content_record = self.get_blog_content_record({ :fields_to_filter => { :id => blog_id }})

			if blog_content_record[:status]
				# Update the blog_content_record
				update_blog_content_record = self.update_blog_content_record({
					:fields_to_filter => { :id      => blog_id },
					:fields_to_update => { :content => content }
				})

				# Set the status or error message
				if update_blog_content_record[:status]
					response_data[:status] 			 = true
					response_data[:result][:content] = content
				else
					response_data[:error] = update_blog_content_record[:error]
				end
			else
				response_data[:error] = blog_content_record[:error]
			end
		rescue Exception => ex
			response_data[:error] = ex.message
		end

		return response_data
	end

	private
		# DOCU: Function to fetch blog_content_record dynamically
		# Triggered by: BlogContentModel
		# Requires: params - fields_to_filter
		# Optionals: params - fields_to_select
		# Last updated at: September 27, 2022
		# Owner: Adrian
		def self.get_blog_content_record(params)
			response_data = { :status => false, :result => {}, :error => nil }

			begin
				params[:fields_to_select] ||= "*"

				select_blog_query = ["
					SELECT #{ActiveRecord::Base.sanitize_sql(params[:fields_to_select])}
					FROM blog_contents WHERE
				"]

				params[:fields_to_filter].each_with_index do |(field, value), index|
					select_blog_query[0] += " #{'AND' if index > 0} #{field} #{field.is_a?(Array) ? 'IN(?)' : '=?'}"
					select_blog_query    << value
				end

				# Query the blog record
				blog_record = query_record(select_blog_query)

				response_data.merge!(blog_record.present? ? { :status => true, :result => blog_record } : { :error => "Error in fetching blog_content record data, Please try again later." })
			rescue Exception => ex
				response_data[:error] = ex.message
			end

			return response_data
		end
		# DOCU: Function to update blog_content_record dynamically
		# Triggered by: BlogContentModel
		# Requires: params - fields_to_filter, fields_to_update
		# Last updated at: September 28, 2022
		# Owner: Adrian
		def self.update_blog_content_record(params)
			response_data = { :status => false, :result => {}, :error => nil }

			begin
				update_blog_content_query = ["
					UPDATE blog_contents SET #{params[:fields_to_update].map{|field, value| "#{field} = '#{ActiveRecord::Base.sanitize_sql(value)}'" }.join(",")}
					WHERE
				"]

				params[:fields_to_update].each_with_index do |(field, value), index|
					update_blog_content_query[0] += " #{"AND" if index > 0} #{field} #{field.is_a?(Array) ? "IN(?)" : "=?"}"
					update_blog_content_query    << value
				end

				response_data.merge!(update_record(update_blog_content_query).present? ? { :status => true } : { :error => "Error in updating blog content record, Please try again later."})
			rescue Exception => ex
				response_data[:error] = ex.message
			end

			return response_data
		end
end
