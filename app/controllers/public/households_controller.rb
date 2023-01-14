class Public::HouseholdsController < ApplicationController

  def index
    @households = Household.all
    @categories = Category.where(id: current_user.category_ids)
  end

  def destroy
    @household = Household.find(params[:id])
    @household.delete
      redirect_to household_accounts_path
      flash.now[:notice] = '投稿を削除しました'
  end


end
