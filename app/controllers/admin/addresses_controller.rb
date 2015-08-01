class Admin::AddressesController < AdminController

  def index
    if params[:user_id]
      @user_id = params[:user_id]
      @addresses = Address.where("user_id = ?", params[:user_id])
    else
      @addresses = Address.all
    end
  end

  def new
    @user = User.find(params[:user_id])
    @address = Address.new
    @cities = City.all.order(:name)
    @states = State.all.order(:name)
  end

  def create
    @user = User.find(params[:address][:user_id])
    if @user.addresses.create(params_list)
      flash[:success] = "Address Created!"
      redirect_to admin_user_path(@user)
    else
      flash[:error] = "Error: Address Not Created"
      render :new
    end
    
  end

  def show
    @address = Address.find(params[:id])   
  end

  def edit
    @address = Address.find(params[:id])
    @user = @address.user
    @cities = City.all.order(:name)
    @states = State.all.order(:name)
  end

  def update
    @address = Address.find(params[:id])
    @user = User.find(params[:address][:user_id])
    if @user.addresses.update(@address.id, params_list)
      flash[:success] = "Address Updated!"
      redirect_to admin_user_path(@user)
    else
      flash[:error] = "Error: Address Not Updated"
      render :new
    end
    
  end

  def destroy
    Address.find(params[:id]).destroy
    redirect_to admin_addresses_path
  end

  private

  def params_list
    params.require(:address).permit(:street_address, :zip_code, :city_id, :state_id)
  end

end
