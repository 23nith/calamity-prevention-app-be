class CreateDonations < ActiveRecord::Migration[7.0]
  def change
    create_table :donations do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :need, null: false, foreign_key: true
      t.decimal :amount

      t.timestamps
    end
  end
end
