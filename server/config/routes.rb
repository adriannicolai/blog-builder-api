Rails.application.routes.draw do
  get 'blog_title/create_blog_title'
  get 'blog_title/update_blog_title'
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

	scope "blog_title" do
		post "create_blog_title" => "blog_title#create_blog_title"
		post "update_blog_title" => "blog_title#update_blog_title"
	end
end
