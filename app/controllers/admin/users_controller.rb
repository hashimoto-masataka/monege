class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
   @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated customer successfully."
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end

  private

  def user_params
  	params.require(:user).permit(:name, :email, :job, :age, :annual_income, :prefecture , :is_deleted)

  end



end
