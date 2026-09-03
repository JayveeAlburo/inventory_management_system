class AddDetailsToProducts < ActiveRecord::Migration[8.1]
  def change
    add_column :products, :cost_price, :decimal, precision: 10, scale: 2, default: 0.0
    add_column :products, :selling_price, :decimal, precision: 10, scale: 2, default: 0.0
    add_column :products, :unit, :string
    add_column :products, :status, :string, default: 'active'
  end
end