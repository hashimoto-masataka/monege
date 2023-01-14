class Public::HouseholdAccountsController < ApplicationController
  before_action :ensure_guest_user, only: [:new ,:destory]

   def new
    @household_account = HouseholdAccount.new
    @categories = current_user.categories
    @sum_target_price = Category.where(id: current_user.category_ids).sum(:target_price)
    @user = current_user
   end

  def create
    # レコード生成に失敗した場合ロールバックする
    # ref: https://blog.furu07yu.com/entry/rails-transaction
    ActiveRecord::Base.transaction do
      household = Household.create(user_id: current_user.id)
      current_user.categories.each do |category|
        HouseholdAccount.create(
            household_id: household.id,
            category_name: category.category_name,
            color: category.color,
            target_price: category.target_price
          )
      end
    end
    redirect_to root_path, notice: "You have created household_account successfully."
    # @household_account = HouseholdAccount.new(household_account_params)
    # @household_account.customer_id = current_customer.id
    # if @household_account.save
    #   redirect_to household_account_path(@household_account), notice: "You have created household_account successfully."
    # else
    #   @household_accounts=HouseholdAccount.all

    #   render 'show'
    # end
  rescue
    @user = current_user
    @categories = current_user.categories
    @household_accounts=HouseholdAccount.all
    render 'show'
  end



  def show
    @household_account = HouseholdAccountt.find(params[:id])
    @categories = @household_account.categories
    @user = @household_account.user
    @sum_target_price = Category.where(id: current_user.category_ids).sum(:target_price)
  end


 
  private

  def household_account_params
    params.require(:household_account).permit(:category_id)
  end

  def ensure_guest_user
    if (current_user.name == "guestuser")&&(current_user.email == 'guest@example.com')
      redirect_to root_path ,notice: 'ゲストユーザーは投稿できません。'
    end
  end
end
