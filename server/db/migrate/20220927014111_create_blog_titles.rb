class CreateBlogTitles < ActiveRecord::Migration[7.0]
  def change
    create_table :blog_titles do |t|
      t.references :blog, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
