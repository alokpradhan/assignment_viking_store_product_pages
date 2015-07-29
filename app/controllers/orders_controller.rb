class OrdersController < ApplicationController

  def index
    if params[:user_id]
      @user_id = params[:user_id]
      @user = User.find(@user_id)
      @orders = Order.where("user_id = ?", params[:user_id])
    else
      @orders = Order.all
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.new(params_list)
    if @order.save
      flash[:success] = "Order Created!"
      redirect_to order_path
    else
      flash[:error] = "Failed to Create Order!"
      render :new
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(param_list)
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
