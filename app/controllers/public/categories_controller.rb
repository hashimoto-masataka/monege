class Public::CategoriesController < ApplicationController

  def new
    @category = Category.new
  end

  def index
    @categories = current_user.categories
    @category= Category.new
    @sum_target_price = Category.where(id: current_user.category_ids).sum(:target_price)
  end

  def show
    @user = User.find(params[:id])
    @categories = @user.categories
    @sum_target_price = Category.where(id: current_user.category_ids).sum(:target_price)
  end

  def edit
    @category= Category.find(params[:id])
  end

  def create
    @category = Category.new(category_params)
    @category.user_id= current_user.id
    @categories = current_user.categories
    if @category.save
      redirect_to categories_path,notice:"新規項目を登録しました"
    else
      render :index
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to categories_path
      flash.now[:notice] = '項目を変更しました'
    else
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    expenses = current_user.expenses
    if expenses.where(category_id: params[:id]).present?
       @categories = current_user.categories
       @sum_target_price = Category.where(id: current_user.category_ids).sum(:target_price)
      render :index
    else
      @category.delete
       redirect_to categories_path
       flash.now[:notice] = '項目を削除しました'
    end
  end

  private

  def category_params
    params.require(:category).permit(:category_name, :color,:target_price)
  end
end
