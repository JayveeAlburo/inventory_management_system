class StockMovement < ApplicationRecord
  belongs_to :product

  MOVEMENT_TYPES = %w[stock_in stock_out].freeze
  validates :movement_type, inclusion: { in: MOVEMENT_TYPES }
  validates :product_id, presence: { message: "Please select a product" }
  validates :quantity, presence: { message: "Quantity cannot be blank" }
  validates :quantity, numericality: { only_integer: true, greater_than: 0, allow_nil: true, message: "Quantity must be greater than 0" }
  validate :sufficient_stock_for_stock_out, if: -> { movement_type == 'stock_out' }

  scope :ordered, -> { order(created_at: :desc) }

  private

  def sufficient_stock_for_stock_out
    return if product.nil? # product presence validated by belongs_to
    if quantity && product.stock_quantity < quantity
      errors.add(:quantity, "Exceeds available stock (#{product.stock_quantity})")
    end
  end
end