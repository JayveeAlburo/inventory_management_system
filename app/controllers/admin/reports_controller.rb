class Admin::ReportsController < Admin::BaseController
  def inventory
    # base query with includes for efficiency
    @products = Product.includes(:category, :supplier)

    # apply filters
    @products = @products.by_category(params[:category_id]) if params[:category_id].present?
    @products = @products.by_supplier(params[:supplier_id]) if params[:supplier_id].present?
    @products = @products.by_stock_status(params[:stock_status]) if params[:stock_status].present?

    # summary metrics for filtered set
    @total_products = @products.count
    @total_stock_quantity = @products.sum(:stock_quantity)
    @total_inventory_cost = @products.sum("cost_price * stock_quantity")
    @total_potential_sales = @products.sum("selling_price * stock_quantity")
    @low_stock_count = @products.low_stock.count
    @out_of_stock_count = @products.out_of_stock.count

    # for filter dropdowns
    @categories = Category.order(:name)
    @suppliers = Supplier.order(:company_name)

    # final product list ordered by name
    @products = @products.order(:name)
  end
end