class Admin::DashboardController < Admin::BaseController
  def index
    # Summary counts
    @total_products = Product.count
    @total_categories = Category.count
    @total_suppliers = Supplier.count
    @total_stock_quantity = Product.sum(:stock_quantity)
    @low_stock_count = Product.low_stock.count
    @out_of_stock_count = Product.out_of_stock.count

    @low_stock_products = Product.low_stock.includes(:supplier).order(:name).limit(5)

    # Recent products
    @recent_products = Product.includes(:category, :supplier)
    .order(created_at: :desc)
    .limit(5)

    # Recent stock movements
    @recent_stock_movements = StockMovement.includes(:product)
    .order(created_at: :desc)
    .limit(5)

    # Low stock products (top 5)
    @low_stock_products = Product.includes(:category, :supplier)
    .where("stock_quantity <= minimum_stock")
    .order(stock_quantity: :asc)
    .limit(5)
  end
end