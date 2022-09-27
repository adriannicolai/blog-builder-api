class CreateBlogContents < ActiveRecord::Migration[7.0]
  def change
    create_table :blog_contents do |t|
      t.references :blogs, null: false, foreign_key: true
      t.references :blog_titles, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
