class CreateSuppliers < ActiveRecord::Migration[8.1]
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :contact_info

      t.timestamps
    end
  end
end
