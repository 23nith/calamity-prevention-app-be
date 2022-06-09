class CreateContactPeople < ActiveRecord::Migration[7.0]
  def change
    create_table :contact_people do |t|
      t.belongs_to :area, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
