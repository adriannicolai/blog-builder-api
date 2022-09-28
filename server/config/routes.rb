Rails.application.routes.draw do
	# Route for users
	scope "user" do
		post "login"	   => "user#login"
		post "register"	   => "user#register"
		post "update_user" => "user#update_user"
	end

	# Route for blogs
	scope "blog" do
		get  "view_blog"   => "blog#view_blog"

		post "create_blog" => "blog#create_blog"
		post "update_log"  => "blog#update_log"
	end

	# Route for blog titles
	scope "blog_title" do
		post "create_blog_title" => "blog_title#create_blog_title"
		post "update_blog_title" => "blog_title#update_blog_title"
	end

	# Route for blog contents
	scope "blog_content" do
		post "create_blog_content" => "blog_content#create_blog_content"
		post "update_blog_content" => "blog_content#update_blog_content"
	end
end
