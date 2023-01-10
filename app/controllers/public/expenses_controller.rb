class Public::ExpensesController < ApplicationController
  def new
    @expense= Expense.new
  end


  def index
    @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    #params[:month]?でmonthが渡れば「：」の左側のData .parse (params [:month]）が適応され、
    #monthがなければ右側のTime.zone.todayが適応される。（なのでindexページは最初は今月分のみ表示される）
    #viewの（month @month.prev_month)でmonthを渡すことでDate.parse(params[:month])が適応される。
    @expenses = current_user.expenses.where(created_at: @month.all_month)
    #where以下でexpensesのうち、created_atが@monthの月のallが表示される。
    @expense= Expense.new
    #@month_record = @expense.group("MONTH(created_at)")
  end

  def edit
    @expense= Expense.find(params[:id])

  end

  def create
    @expense = Expense.new(expense_params)
    @expense.user_id = current_user.id
    @expenses = current_user.expenses
    if @expense.save!
      redirect_to expenses_path
      flash.now[:notice] = "新規支出を登録しました"
    else
      render :index
    end
  end

  def update
    @expense = Expense.find(params[:id])
    if @expense.update(expense_params)
      redirect_to expenses_path
      flash.now[:notice] = '配送先を変更しました'
    else
      render :edit
    end
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.delete
      redirect_to expenses_path
      flash.now[:notice] = '配送先を削除しました'
  end

   def report
    @month = parqams[:month] ? Date.parse(params[:month]) : Timezone.Todey
    @expensess = Expence.whrer(created_at: @month.all_month)
   end


  private

  def expense_params
    params.require(:expense).permit(:price, :created_at, :note, :family_id, :category_id)
  end
end