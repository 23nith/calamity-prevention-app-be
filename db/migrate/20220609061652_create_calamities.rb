class CreateCalamities < ActiveRecord::Migration[7.0]
  def change
    create_table :calamities do |t|
      t.belongs_to :area, null: false, foreign_key: true
      t.date :estimated_date_from
      t.date :estimated_date_to
      t.text :description
      t.string :calamity_type

      t.timestamps
    end
  end
end
