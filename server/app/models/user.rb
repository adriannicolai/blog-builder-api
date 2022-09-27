include ApplicationHelper
include UserHelper
include QueryHelper
class User < ApplicationRecord
        # DOCU: Function to get user record dynamically
        # Triggered by: UserController
        # Requires: params - first_name, last_name, email, password, user_level
        # Last updated at: September 27, 2022
        # Owner: Adrian
        def self.create_new_user(params)
            response_data = { :status => false, :result => {}, :error => nil }

            begin
              	# Check for valid fields
                check_register_form_fields = check_fields(["email", "password", "confirm_password", "first_name", "last_name"], [], params)

                if check_register_form_fields[:status]
                    # Proceed to registering the user if all fields are valid
                    validate_new_user_info = validate_new_user_info(check_register_form_fields[:result])

                    if validate_new_user_info[:status]
                        # Destructure check_register_form_fields
                        first_name, last_name, email, password = check_register_form_fields[:result].values_at(:first_name, :last_name, :email, :password)

                        # Create a new user
                        created_user_id = insert_record(["
                            INSERT INTO users (first_name, last_name, email, password, user_level, created_at, updated_at)
                            VALUES(?, ?, ?, ?, ?, NOW(), NOW())
                        ", first_name.titleize, last_name.titleize, email.downcase, encrypt_password(password), USER_LEVEL_ID[:admin]])

                        if created_user_id.present?
                            # Fetch created user
                            user_details = self.get_user_record({ :fields_to_filter => { :id => created_user_id }, :fields_to_select => "first_name, last_name, email"})

                            # Create a new vlog
                            blog_details = Blog.create_blog({:user_id => created_user_id})

                            response_data.merge!(blog_details[:status] ? { :result => { :user_details => user_details[:result], :blog_details => blog_details[:result] }} : { :error => "Error in creating user and blog record. Please try again later." })
                        else
                            raise "Error in creating user, Please try again later."
                        end
                    else
                        response_data.merge!(validate_new_user_info)
                    end
                else
                    response_data.merge!(check_register_form_fields)
			    end
            rescue Exception => ex
                response_data[:error] = ex.message
            end

            return response_data

        end

    private
        # DOCU: Function to get user record dynamically
        # Triggered by: UserController
        # Requires: params - fields_to_filter
        # Optionals: params - fields_to_select
        # Last updated at: September 26, 2022
        # Owner: Adrian
        def self.get_user_record(params)
            response_data = { :status => false, :result => {}, :error => nil }

            begin
                params[:fields_to_select] ||= "*"

                select_user_query = ["
                    SELECT #{ActiveRecord::Base.sanitize_sql(params[:fields_to_select])}, CONCAT(first_name, ' ', last_name) AS full_name
                    FROM users WHERE
                "]

                params[:fields_to_filter].each_with_index do |(field, value), index|
                    select_user_query[0] += "#{' AND' if index > 0} #{field} #{value.is_a?(Array) ? 'IN(?)' : '=?'}"
                    select_user_query    << value
                end

                # Run the select query
                user_record = query_record(select_user_query)

                response_data.merge!(user_record.present? ? { :status => true, :result => user_record } : { :error => "User not found."})
            rescue Exception => ex
                response_data[:error] = ex.message
            end

            return response_data
        end
end
