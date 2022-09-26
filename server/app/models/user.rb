include QueryHelper
class User < ApplicationRecord
    private
        # DOCU: Function to get user record dynamiccally
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
