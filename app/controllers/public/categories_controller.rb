class Public::CategoriesController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_category,only: [:edit,:show]

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
      redirect_to categories_path,notice:"新たに項目を登録しました"
    else
      render :new
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to categories_path,notice:'項目内容を変更しました'
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
       flash[:alret] = "この項目は他の収入・支出で使用しているため削除できません"
      redirect_to categories_path
    else
      @category.delete
       redirect_to categories_path,notice:'項目を削除しました'
       
    end
  end
  
  def correct_category
      @category = Category.find(params[:id])
        unless @category.user.status == true
          redirect_to users_path
        end
  #urlに直打ちされた際に公開ステータスがtrue以外はuser一覧にリダイレクトされる
  end

  private

  def category_params
    params.require(:category).permit(:category_name, :color,:target_price)
  end
end
