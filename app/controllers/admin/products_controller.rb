class Admin::ProductsController < AdminController

  include CategoriesHelper
  
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    @products = @product.orders
    flash[:success] = "Show page coming soon"
    redirect_to admin_products_path
  end

  def new
    @product = Product.new
    @category_names = categories_array
    @categories = Category.all 
  end

  def create
    @product = Product.new(params_hash)
    @product.sku = Faker::Code.ean.to_i
    if @product.save
      
      flash[:success] = "Product Created Successfully"
      redirect_to admin_products_path
    else 
      flash.now[:error] = "Failed to created Product. Please Try again"
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
    @categories = Category.all

  end

  def update
    @product = Product.find(params[:id])
    if @product.update(params_hash)
      redirect_to admin_products_path
      flash[:success] = "Product Updated"
    else
      flash.now[:error] = "Failed to update. Please Try again"
      render :edit
    end

  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:success] = "OBLITERATED"
    redirect_to admin_products_path
  end
  
  private

    def params_hash
      params.require(:product).permit(:name, :description, :price, :category_id)
    end
end
