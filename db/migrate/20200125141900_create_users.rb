class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :password
      t.string :email
      t.string :image_url
      t.date :date_of_birth
      t.boolean :active
      t.string :name
      t.integer :showoff_user_id
      t.string :showoff_access_token
      t.string :showoff_refresh_token
      t.timestamps
    end
  end
end
