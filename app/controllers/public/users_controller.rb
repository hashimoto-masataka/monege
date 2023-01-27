class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit ,:unsubscribe]
  #ゲストユーザーがカスタマーの編集ページに直接入力しても遷移できないようにする。

  def index
    user = User.where(status: true) 
    user_deleted = user.where(is_deleted: false)
    @users = user_deleted.all.includes(:categories).page(params[:page]).per(7)
    @users_data = @users.map do |user|
      categories = user.categories
      {
        id: user.id,
        category_names: (categories.any? ? categories.map{|c| c.category_name} : [""]),
        target_prices: (categories.any? ? categories.map{|c| c.target_price} : [0])
      }
    end
  end

  def show
    @user = current_user
    @categories = @user.categories


    @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    #params[:month]?でmonthが渡れば「：」の左側のData .parse (params [:month]）が適応され、
    #monthがなければ右側のTime.zone.todayが適応される。（なのでindexページは最初は今月分のみ表示される）
    #viewの（month @month.prev_month)でmonthを渡すことでDate.parse(params[:month])が適応される。

    @current_month_beginning = @month.beginning_of_month
    @current_month_end = @month.end_of_month
    @expenses = current_user.expenses.where(created_at: @month.all_month)
    @incomes = current_user.incomes.where(created_at: @month.all_month)
    #where以下でexpensesのうち、created_atが@monthの月のallが表示される。
    @sum_price_expense = @expenses.where(id: current_user.expense_ids).sum(:price)
    @sum_price_income = @incomes.where(id: current_user.income_ids).sum(:price)
    @sum_target_price = Category.where(id: current_user.category_ids).sum(:target_price)
    
    @expense_chart = current_user.expenses.where(created_at: @month.all_month).group(:category_id)
    
    @saving = @sum_price_income - @sum_price_expense
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
       flash[:success] = "登録情報を変更しました"
       redirect_to users_my_page_path(current_user)
    else
       render :edit
    end
  end

  def unsubscribe

  end

  def withdraw
    @user = current_user
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end



private

 def user_params
  	params.require(:user).permit(:name, :email, :job, :age, :annual_income, :prefecture, :status ,:is_deleted)

 end


 def ensure_guest_user
    if (current_user.name == "guestuser")&&(current_user.email == 'guest@example.com')
      redirect_to root_path ,notice: 'ゲストユーザーはマイページの編集はできません。'
    end
 end
end
