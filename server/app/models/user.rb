include QueryHelper
class User < ApplicationRecord
        # DOCU: Function to get user record dynamically
        # Triggered by: UserController
        # Requires: params - first_name, last_name, email, password, user_level
        # Last updated at: September 26, 2022
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
                        first_name, last_name, email, password = check_register_form_fields.values_at(:first_name, :last_name, :email, :password)

                        # Create a new user
                        create_user_id = "
                            INSERT INTO users (first_name, last_name, email, password, user_level, created_at, updated_at)
                            VALUES(?, ?, ?, ?, ?, NOW(), NOW())
                        ", first_name, last_name, email, password, USER_LEVEL_ID[:admin]
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
                    SELECT #{ActiveRecord::Base.sanitize_sql(params[:fields_to_select])}
                    FROM users WHERE
                "]

                params[:fields_to_filter].each_with_index do |(field, value), index|
                    select_user_query[0] += "#{' AND' if index > 0} #{field} #{value.is_a?(Array) ? 'IN(?)' : '=?'}"
                    select_user_query    << value
                end

                # Run the select query
                user_record = query_record(select_user_query)

                if user_record.present?
                    response_data[:status] = true
                    response_data[:result] = user_record
                else
                    response_data[:error] = "User not found"
                end
            rescue Exception => ex
                response_data[:error] = ex.message
            end

            return response_data
        end
end
