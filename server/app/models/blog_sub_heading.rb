class BlogSubHeading < ApplicationRecord
  belongs_to :blogs
  belongs_to :blog_titles
end
