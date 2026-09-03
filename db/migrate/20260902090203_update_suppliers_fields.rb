class UpdateSuppliersFields < ActiveRecord::Migration[8.1]
  def change
    # Remove old columns
    remove_column :suppliers, :name, :string
    remove_column :suppliers, :contact_info, :string

    # Add new columns
    add_column :suppliers, :company_name, :string
    add_column :suppliers, :contact_person, :string
    add_column :suppliers, :email, :string
    add_column :suppliers, :phone, :string
    add_column :suppliers, :address, :text
    add_column :suppliers, :status, :string, default: 'active'
    add_column :suppliers, :notes, :text
  end
end