class Admin::OrdersController < AdminController

  def index
    if params[:user_id]
      @user_id = params[:user_id]
      @user = User.find(@user_id)
      @orders = Order.includes({:shipping_address => [:state, :city]}, :order_contents, :billing_address, :user, :products).where("user_id = ?", params[:user_id])
    else
      @orders = Order.includes({:shipping_address => [:state, :city]}, :order_contents, :billing_address, :user, :products)
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @order = @user.orders.new
  end

  def create
    @user = User.find(params[:user_id])
    @order = @user.orders.new(params_list)
    if @order.save
      flash[:success] = "Order Created!"
      redirect_to edit_order_path(@order)
    else
      flash[:error] = "Failed to Create Order!"
      render :new
    end
  end

  def edit
    @order = Order.find(params[:id])
    @user = @order.user
    @cart = OrderContent.where(:order_id => @order.id)
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(params_list)
      flash[:success] = "Order Updated!"
      redirect_to order_path
    else
      flash[:error] = "Could not Update Order"
      render :edit
    end
  end

  def destroy
    @order = Order.find(params[:id])
    if @order.destroy
      flash[:success] = "Order Deleted"
      redirect_to orders_path
    else
      flash[:error] = "Could not Delete Order"
      redirect_to orders_path
    end
  end
end

private

def params_list

  params.require(:order).permit(:billing_id, :shipping_id)

end
