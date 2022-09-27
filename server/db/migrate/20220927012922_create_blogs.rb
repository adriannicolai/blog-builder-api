class CreateBlogs < ActiveRecord::Migration[7.0]
  def change
    create_table :blogs do |t|
      t.references :users, null: false, foreign_key: true
      t.string :name, limit: 255
      t.string :blog_logo, limit: 255

      t.timestamps
    end
  end
end
