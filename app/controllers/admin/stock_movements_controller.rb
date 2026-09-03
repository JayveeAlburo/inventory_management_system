class Admin::StockMovementsController < Admin::BaseController
  before_action :set_stock_movement, only: [:show]
  before_action :set_products, only: [:new_in, :new_out, :create]

  def index
    @pagy, @stock_movements = pagy(StockMovement.includes(:product).ordered, items: 15)
  end

  def show
  end

  def new_in
    @stock_movement = StockMovement.new(movement_type: 'stock_in')
  end

  def new_out
    @stock_movement = StockMovement.new(movement_type: 'stock_out')
  end

  def create
    @stock_movement = StockMovement.new(stock_movement_params)

    if @stock_movement.movement_type == 'stock_in'
      process_movement(:increment!)
    elsif @stock_movement.movement_type == 'stock_out'
      process_movement(:decrement!)
    else
      @stock_movement.errors.add(:movement_type, "is invalid")
      render_invalid_template
    end
  end

  private

  def set_stock_movement
    @stock_movement = StockMovement.find(params[:id])
  end

  def set_products
    @products = Product.active.order(:name)
  end

  def stock_movement_params
    params.require(:stock_movement).permit(:product_id, :movement_type, :quantity, :reason)
  end

  def process_movement(operation)
    product = Product.find_by(id: @stock_movement.product_id)

    unless product
      @stock_movement.errors.add(:product_id, "Please select a product")
      return render_invalid_template
    end

    ActiveRecord::Base.transaction do
      product.with_lock do
        @stock_movement.save!                      # validations run here
        product.public_send(operation, :stock_quantity, @stock_movement.quantity)
      end
    end

    redirect_to admin_stock_movements_path, notice: "Stock movement recorded successfully."
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
    @stock_movement.errors.merge!(e.record.errors) if e.respond_to?(:record)
    render_invalid_template
  end

  def render_invalid_template
    template = @stock_movement.movement_type == 'stock_in' ? :new_in : :new_out
    render template, status: :unprocessable_entity
  end
end