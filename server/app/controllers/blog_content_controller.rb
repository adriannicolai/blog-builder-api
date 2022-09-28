class BlogContentController < ApplicationController
    # DOCU: Function creating additional blog content
    # Triggered by: (POST) /blog_content/create_blog_content
    # Requires params - blog_id, blog_title_id
    # Last updated at: September 28, 2022
    # Owner: Adrian
    def create_blog_content
        response_data = { :status => false, :result => {}, :error => nil }

        begin
            response_data = BlogContent.create_blog_title_content(params)
        rescue Exception => ex
            response_data[:error] = ex.message
        end

        render :json => response_data
    end

    def update_blog_content

    end
end
