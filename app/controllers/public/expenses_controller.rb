class Public::ExpensesController < ApplicationController
  before_action :authenticate_user!

  def new
    @expense= Expense.new
  end


  def index
    all_expenses = current_user.expenses.page(params[:page]).per(7)
    @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    #params[:month]?でmonthが渡れば「：」の左側のData .parse (params [:month]）が適応され、
    #monthがなければ右側のTime.zone.todayが適応される。（なのでindexページは最初は今月分のみ表示される）
    #viewの（month @month.prev_month)でmonthを渡すことでDate.parse(params[:month])が適応される。
    @expenses = all_expenses.where(created_at: @month.all_month)
    #where以下でexpensesのうち、created_atが@monthの月のallが表示される。
    
    @current_month_beginning = @month.beginning_of_month
    @current_month_end = @month.end_of_month
    expenses_total = current_user.expenses.where(created_at: @month.all_month)
    @sum_price = expenses_total.where(id: current_user.expense_ids).sum(:price)
    @expense_chart = current_user.expenses.select('id, sum(price) as price, category_id').where(created_at: @month.all_month).group(:category_id)
    
    line_monthes = (1..12)
    current_year = Time.zone.now.year
    current_year_range = (Time.zone.now.beginning_of_year..Time.zone.now.end_of_year)
    #１年のレンジを定義
    expenses = current_user.expenses
    year_expenses = expenses.where(created_at: current_year_range)
    @line_monthes = line_monthes.map{|i| i.to_s + "月"}
    @line_datas = line_monthes.map do |i|
      time_zone_local = Time.zone.local(current_year, i, 1, 0, 0, 0)
      #time.zone.local
      year_expenses.where(created_at: time_zone_local..time_zone_local.end_of_month)
    end.map{|o| o.any? ? o.pluck(:price).sum : 0}
    #「o」はobjectの略、取り出したexpenseにobject（要素）が入っていればpluckでpriceを取り出し、要素がなければ0で取り出す。

  end

  def edit
    @expense= Expense.find(params[:id])

  end

  def create
    @expense = Expense.new(expense_params)
    @expense.user_id = current_user.id
    @expenses = current_user.expenses
    if @expense.save
      redirect_to expenses_path,notice:"新たに支出を登録しました"
    else
      render :new
    end
  end

  def update
    @expense = Expense.find(params[:id])
    if @expense.update(expense_params)
      redirect_to expenses_path,notice:'登録した支出内容を変更しました'
    else
      render :edit
    end
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.delete
    flash[:alret] ='登録した支出を削除しました'
    redirect_to expenses_path
      
  end

   


  private

  def expense_params
    params.require(:expense).permit(:price, :created_at, :note, :family_id, :category_id)
  end
end
