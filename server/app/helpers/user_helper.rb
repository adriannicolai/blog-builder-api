module UserHelper
    # DOCU: Validate new user information
    # Triggered by: multiple models
    # Requires: params
    # Returns: { status, result{params}, error }
    # Last updated at: September 26, 2022
    # Owner: Adrian
    def validate_new_user_info(params)
        response_data = { :status => false, :result => {}, :error => nil }

        begin
            validations = {
                :name     => { :regex => /[@%^&!"\\\*\.,\-\:?\/\'=`{}()+_\]\|\[\><~;$#0-9]/, :error => "Special Characters are not allowed on name" },
                :password => { :regex => /^(?=.*?[A-Z])(?=.*?[0-9]).{0,}$/, :error => "Password must have an uppercase letter and a number" },
                :email    => { :regex => URI::MailTo::EMAIL_REGEXP, :error => "Please enter a valid email" }
            }

            # Iterate each parameters and do a validation
            params.each do |key, value|
                validation_key = [:first_name, :last_name].include?(key) ? :name : key

                if validation_key === :password && params[:confirm_password].present?
                    response_data[:password] = "Passwords do not match" if value != params[:confirm_password]
                end

                # Skip theh regex mathing if the key is not present in the validations hash
                next if !validations.include?(validation_key)

                # Compare the regex values
                validation_comparison = validations[validation_key][:regex] =~ value

                response_data[:result][validation_key] = validations[validation_key][:error] if validation_key === :name ? !validation_comparison.nil? : validation_comparison.nil?
            end
        rescue Exception => ex
            response_data[:error] = ex.message
        end

        p "response_data"
        p response_data
        p "response_data"
        p "response_data"
        return response_data
    end
end
