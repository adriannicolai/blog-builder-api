class CreateBlogSubHeadings < ActiveRecord::Migration[7.0]
  def change
    create_table :blog_sub_headings do |t|
      t.references :blogs, null: false, foreign_key: true
      t.references :blog_titles, null: false, foreign_key: true
      t.string :name, limit: 255

      t.timestamps
    end
  end
end
