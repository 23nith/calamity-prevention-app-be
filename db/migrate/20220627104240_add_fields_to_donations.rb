class AddFieldsToDonations < ActiveRecord::Migration[7.0]
  def change
    add_column :donations, :is_paid, :boolean
    add_column :donations, :payment_type, :string
    add_column :donations, :source, :string
  end
end
