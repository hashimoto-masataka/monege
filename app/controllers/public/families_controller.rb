class Public::FamiliesController < ApplicationController
  before_action :authenticate_user!

  def index
    @families = current_user.families
    @family_new= Family.new
   
    @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    @current_month_beginning = @month.beginning_of_month
    @current_month_end = @month.end_of_month
    
    all_expenses = current_user.expenses
    @expenses = all_expenses.where(created_at: @month.all_month)
    expenses_total = current_user.expenses.where(created_at: @month.all_month)
    @sum_price = expenses_total.where(id: current_user.expense_ids).sum(:price)
    @family_chart = current_user.expenses.select('sum(price) as price, family_id').where(created_at: @month.all_month).group(:family_id)
    


  end

  def edit
    @family= Family.find(params[:id])

  end

  def create
    @family = Family.new(family_params)
    @family.user_id= current_user.id
    @families = current_user.families
    if @family.save
      
      redirect_to families_path,notice:'新規家族を登録しました'
    else
      render :index
    end
  end

  def update
    @family = Family.find(params[:id])
    if @family.update(family_params)
      redirect_to families_path,notice:'家族名を変更しました'
      
    else
      render :edit
    end
  end

  def destroy
    @families = current_user.families
    @family_new= Family.new
    @family = Family.find(params[:id])
    expenses = current_user.expenses
    incomes = current_user.incomes
    if expenses.where(family_id: params[:id]).present? || incomes.where(family_id: params[:id]).present?
      flash[:alret] = '家族名を収支で使用しているため削除できません'
      redirect_to families_path 
      
    else
      @family.delete
      redirect_to families_path,notice:'家族名を削除しました'
      
    end
  end

  private

  def family_params
    params.require(:family).permit(:family_name)
  end
end
