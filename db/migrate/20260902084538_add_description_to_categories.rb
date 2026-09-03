class AddDescriptionToCategories < ActiveRecord::Migration[8.1]
  def change
    add_column :categories, :desciption, :text
  end
end
