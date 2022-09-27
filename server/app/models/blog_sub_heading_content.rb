class BlogSubHeadingContent < ApplicationRecord
  belongs_to :blog
  belongs_to :blog_title
  belongs_to :blog_sub_heading
end
