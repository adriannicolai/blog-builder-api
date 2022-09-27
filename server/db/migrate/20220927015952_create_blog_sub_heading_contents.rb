class CreateBlogSubHeadingContents < ActiveRecord::Migration[7.0]
  def change
    create_table :blog_sub_heading_contents do |t|
      t.references :blog, null: false, foreign_key: true
      t.references :blog_title, null: false, foreign_key: true
      t.references :blog_sub_heading, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
