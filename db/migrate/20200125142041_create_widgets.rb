class CreateWidgets < ActiveRecord::Migration[5.2]
  def change
    create_table :widgets do |t|
      t.string :name
      t.string :description
      t.string :kind
      t.integer :user_id
      t.integer :showoff_widget_id
      t.timestamps
    end
  end
end
