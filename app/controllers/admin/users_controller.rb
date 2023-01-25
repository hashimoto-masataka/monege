class Admin::UsersController < ApplicationController
  def index
    user = User.where(status: true) and User.where(is_deleted: false)
    @users = user.all.page(params[:page]).per(7)
    

  end

  def show
    @user = User.find(params[:id])
    @categories = @user.categories


    @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    #params[:month]?でmonthが渡れば「：」の左側のData .parse (params [:month]）が適応され、
    #monthがなければ右側のTime.zone.todayが適応される。（なのでindexページは最初は今月分のみ表示される）
    #viewの（month @month.prev_month)でmonthを渡すことでDate.parse(params[:month])が適応される。

    @current_month_beginning = @month.beginning_of_month
    @current_month_end = @month.end_of_month
    @expenses = @user.expenses.where(created_at: @month.all_month)
    @incomes = @user.incomes.where(created_at: @month.all_month)
    #where以下でexpensesのうち、created_atが@monthの月のallが表示される。
    @sum_price_expense = @expenses.where(id: @user.expense_ids).sum(:price)
    @sum_price_income = @incomes.where(id: @user.income_ids).sum(:price)
    @sum_target_price = Category.where(id: @user.category_ids).sum(:target_price)
    
    @saving = @sum_price_income - @sum_price_expense
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       flash[:success] = "登録情報を変更しました"
       redirect_to admin_user_path(@user)
    else
       render :edit
    end
  end
  
  def unsubscribe

  end

  def withdraw
    @user = User.find(params[:id])
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
end
