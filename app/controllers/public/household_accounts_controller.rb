class Public::HouseholdAccountsController < ApplicationController
  before_action :ensure_guest_user, only: [:new ,:destory]

   def new
    @household_account = HouseholdAccount.new
    @categories = current_user.categories
    @sum_target_price = Category.where(id: current_user.category_ids).sum(:target_price)
    @user = current_user
   end

  def create
    @household_account = Household.new(household_account_params)
    @user = current_user
    @household_account.user_id= @user.id
    @categories = current_user.categories
    if @household_account.save
      redirect_to root_path
      flash.now[:notice] = "家計簿を投稿しました"
    else
      render :index
    end
  end



  def index
    @categories = current_user.categories
    @sum_target_price = Category.where(id: current_user.category_ids).sum(:target_price)
    # @household_account = HouseholdAccount.new
    @households = Household.all
  end

  def show
    @household_account = HouseholdAccountt.find(params[:id])
    @categories = @household_account.categories
    @user = @household_account.user
    @sum_target_price = Category.where(id: current_user.category_ids).sum(:target_price)
  end


  def destroy
    @household_account = HouseholdAccount.find(params[:id])
    @household_account.delete
      redirect_to household_accounts_path
      flash.now[:notice] = '投稿を削除しました'
  end

  private

  def household_account_params
    params.require(:household_account).permit(:category_name, :target_price)
  end

  def ensure_guest_user
    if (current_user.name == "guestuser")&&(current_user.email == 'guest@example.com')
      redirect_to root_path ,notice: 'ゲストユーザーは投稿できません。'
    end
  end
end
