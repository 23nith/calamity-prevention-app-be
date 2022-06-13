class AddFieldsToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :area, null: false, foreign_key: true
    add_column :users, :address, :text
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :longitude, :float
    add_column :users, :latitude, :float
    add_column :users, :role, :string
  end
end
