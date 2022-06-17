class CreateAreas < ActiveRecord::Migration[7.0]
  def change
    create_table :areas do |t|
      t.text :address
      t.string :name
      t.float :longitude
      t.float :latitude
      t.float :radius

      t.timestamps
    end
  end
end
