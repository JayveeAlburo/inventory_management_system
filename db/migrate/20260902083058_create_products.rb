class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :sku
      t.text :description
      t.integer :stock_quantity
      t.integer :minimum_stock
      t.references :category, null: false, foreign_key: true
      t.references :supplier, null: false, foreign_key: true

      t.timestamps
    end
  end
end
