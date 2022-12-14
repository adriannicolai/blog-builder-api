module ApplicationHelper
    # DOCU: Function to check required and optional fields
    # Triggered by:
    # Requires: required_fields - [], optional_fields - []
    # Last updated at: September 26, 2022
    # Owner: Adrian
    def check_fields(required_fields = [], optional_fields = [], params)
        response_data = { :status => false, :result => {}, :error => nil }

        begin
            invalid_fields = []
            all_fields     = required_fields + optional_fields

            all_fields.each do |key|
                if params[key].present?
                    response_data[:result][key] = params[key].is_a?(String) ? params[key].strip : params[key]
                elsif required_fields.include?(key)
                    invalid_fields << key
                    response_data[:error] = "Missing required fields"
                end
            end

            response_data.merge!(invalid_fields.empty? ? { :status => true, :result => response_data[:result].symbolize_keys } : { :result => invalid_fields, :error => "Missing required fields" })
        rescue Exception => ex
            response_data[:error] = ex.message
        end

        return response_data
    end

    # DOCU: Function encrypt basic information
    # Triggered by:
    # Last updated at: September 26, 2022
    # Owner: Adrian
    def encrypt text
        Base64.urlsafe_encode64( ((text.to_i*88)+ENV['HIDING_KEY'].to_i).to_s + ENV['ENCRYPTION_KEY'] + text.to_s)
    end

    # DOCU: Function decrypt basic information
    # Triggered by:
    # Last updated at: September 26, 2022
    # Owner: Adrian
    def decrypt encrypted_text
        Base64.urlsafe_decode64(encrypted_text).split(ENV['ENCRYPTION_KEY'])[1]
    end

    # DOCU: Function to encrypt password
    # Triggered: by
    # Requires: password
    # Last updated at: September 26, 2022
    # Owner: Adrian
    def encrypt_password(password)
        Digest::MD5.hexdigest("#{ENV["PASSWORD_PREFIX"]}#{password}password#{ENV["PASSWORD_SUFFIX"]}")
    end
end
