class Admin::ProductsController < Admin::BaseController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.includes(:category, :supplier)

    # search
    @products = @products.search(params[:search]) if params[:search].present?

    # filters
    @products = @products.by_category(params[:category_id]) if params[:category_id].present?
    @products = @products.by_supplier(params[:supplier_id]) if params[:supplier_id].present?
    @products = @products.by_stock_status(params[:stock_status]) if params[:stock_status].present?
    @products = @products.where(status: params[:status]) if params[:status].present?

    # sorting
    sort_column = %w[name sku stock_quantity created_at selling_price].include?(params[:sort]) ? params[:sort] : 'created_at'
    sort_direction = %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
    @products = @products.order("#{sort_column} #{sort_direction}")

    # pagination with Pagy
    @pagy, @products = pagy(@products, items: 15, params: request.query_parameters.except('page'))

    # for filter dropdowns
    @categories = Category.order(:name)
    @suppliers = Supplier.order(:company_name)
  end

  def show
    @recent_stock_movements = @product.stock_movements.order(created_at: :desc).limit(5)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_product_path(@product), notice: "Product was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to admin_product_path(@product), notice: "Product was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @product.destroy
      redirect_to admin_products_path, notice: "Product was successfully deleted."
    else
      redirect_to admin_products_path, alert: "Product could not be deleted."
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(
      :name,
      :sku,
      :description,
      :category_id,
      :supplier_id,
      :cost_price,
      :selling_price,
      :minimum_stock,
      :unit,
      :status
    )
  end
end