class Admin::SuppliersController < Admin::BaseController
  before_action :set_supplier, only: [:show, :edit, :update, :destroy]

  def index
    @pagy, @suppliers = pagy(Supplier.ordered.includes(:products), items: 15)
  end

  def show
    @products = @supplier.products.ordered
  end

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new(supplier_params)
    if @supplier.save
      redirect_to admin_supplier_path(@supplier), notice: "Supplier was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @supplier.update(supplier_params)
      redirect_to admin_supplier_path(@supplier), notice: "Supplier was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @supplier.destroy
      redirect_to admin_suppliers_path, notice: "Supplier was successfully deleted."
    else
      redirect_to admin_suppliers_path, alert: "Supplier cannot be deleted because it has associated products."
    end
  end

  private

  def set_supplier
    @supplier = Supplier.find(params[:id])
  end

  def supplier_params
    params.require(:supplier).permit(
      :company_name,
      :contact_person,
      :email,
      :phone,
      :address,
      :status,
      :notes
    )
  end
end