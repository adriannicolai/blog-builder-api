class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name, limit: 255
      t.string :last_name, limit: 255
      t.string :email, limit: 255
      t.string :password, limit: 255
      t.integer :user_level, limit: 1

      t.timestamps
    end
  end
end
