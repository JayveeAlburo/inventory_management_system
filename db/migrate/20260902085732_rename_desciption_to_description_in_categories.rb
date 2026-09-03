class RenameDesciptionToDescriptionInCategories < ActiveRecord::Migration[8.1]
  def change
    rename_column :categories, :desciption, :description
  end
end
