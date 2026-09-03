class Admin::CategoriesController < Admin::BaseController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @pagy, @categories = pagy(Category.ordered.includes(:products), items: 15)
  end

  def show
    @products = @category.products.ordered
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path(@category), notice: "Category was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to admin_category_path(@category), notice: "Category was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @category.destroy
      redirect_to admin_categories_path, notice: "Category was successfully deleted."
    else
      redirect_to admin_categories_path, alert: "Category cannot be deleted because it has associated products."
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description)
  end
end