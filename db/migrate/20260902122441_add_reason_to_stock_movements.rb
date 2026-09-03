class AddReasonToStockMovements < ActiveRecord::Migration[8.1]
  def change
    add_column :stock_movements, :reason, :text
  end
end
