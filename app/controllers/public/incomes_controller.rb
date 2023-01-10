class Public::IncomesController < ApplicationController
  def new
  end

  def index
    @incomes = current_user.incomes
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
