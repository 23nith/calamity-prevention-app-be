class CreateNeeds < ActiveRecord::Migration[7.0]
  def change
    create_table :needs do |t|
      t.belongs_to :calamity, null: false, foreign_key: true
      t.decimal :cost
      t.integer :count
      t.text :description

      t.timestamps
    end
  end
end
