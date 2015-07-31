class Admin::CategoriesController < AdminController

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @products = @category.products
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params_hash)
    if @category.save
      flash[:success] = "Category Created Successfully"
      redirect_to categories_path
    else 
      flash.now[:error] = "Failed to created Category. Please Try again"
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(params_hash)
      redirect_to categories_path
      flash[:success] = "Category Updated"
    else
      flash.now[:error] = "Failed to update. Please Try again"
      render :edit
    end

  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path
  end
  
  private

    def params_hash
      params.require(:category).permit(:name, :description)
    end
end
