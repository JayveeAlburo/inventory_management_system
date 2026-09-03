class Product < ApplicationRecord
  belongs_to :category
  belongs_to :supplier
  has_many :stock_movements, dependent: :destroy

  STATUS_OPTIONS = %w[active inactive].freeze

  before_validation :set_default_stock_quantity, on: :create

  validates :name, presence: { message: "Name can't be blank" },
  length: { maximum: 150, message: "Name is too long (maximum is 150 characters)" }

  validates :sku, presence: { message: "SKU can't be blank" },
  uniqueness: { message: "SKU already exists" },
  length: { maximum: 50, message: "SKU is too long (maximum is 50 characters)" }
  
  validates :category_id, presence: { message: "Category can't be blank" }
  validates :supplier_id, presence: { message: "Supplier can't be blank" }
  validates :cost_price, numericality: { greater_than_or_equal_to: 0, message: "Cost price must be greater than or equal to 0" }
  validates :selling_price, numericality: { greater_than_or_equal_to: 0, message: "Selling price must be greater than or equal to 0" }
  validates :stock_quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0, message: "Stock quantity must be a non-negative integer" }
  validates :minimum_stock, numericality: { only_integer: true, greater_than_or_equal_to: 0, message: "Minimum stock must be a non-negative integer" }
  validates :status, inclusion: { in: STATUS_OPTIONS, message: "Status must be active or inactive" }

  scope :ordered, -> { order(created_at: :desc) }
  scope :active, -> { where(status: 'active') }
  scope :inactive, -> { where(status: 'inactive') }
  scope :in_stock, -> { where("stock_quantity > minimum_stock") }
  scope :low_stock, -> { where("stock_quantity > 0 AND stock_quantity <= minimum_stock") }
  scope :out_of_stock, -> { where(stock_quantity: 0) }
  scope :search, ->(query) { where("name ILIKE ? OR sku ILIKE ?", "%#{query}%", "%#{query}%") if query.present? }
  scope :by_category, ->(category_id) { where(category_id: category_id) if category_id.present? }
  scope :by_supplier, ->(supplier_id) { where(supplier_id: supplier_id) if supplier_id.present? }
  scope :by_stock_status, ->(status) {
    case status
    when 'in_stock'
      in_stock
    when 'low_stock'
      low_stock
    when 'out_of_stock'
      out_of_stock
    end
  }

  def stock_status
    if stock_quantity == 0
      'out_of_stock'
    elsif stock_quantity <= minimum_stock
      'low_stock'
    else
      'in_stock'
    end
  end

  def stock_status_label
    case stock_status
    when 'in_stock' then 'In Stock'
    when 'low_stock' then 'Low Stock'
    when 'out_of_stock' then 'Out of Stock'
    end
  end

  private

  def set_default_stock_quantity
    self.stock_quantity ||= 0
  end
end