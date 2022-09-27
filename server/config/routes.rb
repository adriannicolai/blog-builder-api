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
end
