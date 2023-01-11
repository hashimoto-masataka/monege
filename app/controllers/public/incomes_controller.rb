class Public::IncomesController < ApplicationController
  def new
    @income = Income.new
  end

  def index
    @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    #params[:month]?でmonthが渡れば「：」の左側のData .parse (params [:month]）が適応され、
    #monthがなければ右側のTime.zone.todayが適応される。（なのでindexページは最初は今月分のみ表示される）
    #viewの（month @month.prev_month)でmonthを渡すことでDate.parse(params[:month])が適応される。
    @incomes = current_user.incomes.where(created_at: @month.all_month)
    #where以下でexpensesのうち、created_atが@monthの月のallが表示される。
    @income= Income.new
    @sum_price = Income.where(id: current_user.income_ids).sum(:price)
  end

  def edit
    @income= Income.find(params[:id])

  end

  def create
    @income = Income.new(income_params)
    @income.user_id = current_user.id
    @incomes = current_user.incomes
    if @income.save!
      redirect_to incomes_path
      flash.now[:notice] = "収入を登録しました"
    else
      render :index
    end
  end

  def update
    @income = Income.find(params[:id])
    if @income.update(incomes_params)
      redirect_to incomes_path
      flash.now[:notice] = '収入を変更しました'
    else
      render :edit
    end
  end

  def destroy
    @income = Income.find(params[:id])
    @income.delete
      redirect_to incomes_path
      flash.now[:notice] = '収入を削除しました'
  end

  private

  def income_params
    params.require(:income).permit(:price, :created_at, :note, :family_id)
  end
end
