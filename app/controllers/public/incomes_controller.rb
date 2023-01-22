class Public::IncomesController < ApplicationController
  before_action :authenticate_user!
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
    @current_month_beginning = @month.beginning_of_month
    @current_month_end = @month.end_of_month
    @income= Income.new
    @sum_price = @incomes.where(id: current_user.income_ids).sum(:price)
    line_monthes = (1..12)
    current_year = Time.zone.now.year
    current_year_range = (Time.zone.now.beginning_of_year..Time.zone.now.end_of_year)
    #１年のレンジを定義
    year_incomes = Income.where(created_at: current_year_range)
    @line_monthes = line_monthes.map{|i| i.to_s + "月"}
    @line_datas = line_monthes.map do |i|
      time_zone_local = Time.zone.local(current_year, i, 1, 0, 0, 0)
      #time.zone.local
      year_incomes.where(created_at: time_zone_local..time_zone_local.end_of_month)
    end.map{|o| o.any? ? o.pluck(:price).sum : 0 }
    #「o」はobjectの略、取り出したexpenseにobject（要素）が入っていればpluckでpriceを取り出し、要素がなければ0で取り出す。
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
    if @income.update(income_params)
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
