class Admin::UsersController < AdminController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params_hash)
    if @user.save
      flash[:success] = "New User Created"
      redirect_to admin_users_path
    else
      flash[:error] = "Error: New User Not Created"
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @orders = @user.orders
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(params_hash)
      flash[:success] = "User Successfully Updated"
      redirect_to admin_user_path(@user)
    else
      flash[:error] = "Failed to Update User"
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:error] = "User Successfully Deleted"
      redirect_to admin_users_path
    else
      flash[:error] = "Failed to Delete User"
      redirect_to admin_users_path
    end
  end


  private

  def params_hash
    params.require(:user).permit(:first_name, :last_name, :email)
  end


end
