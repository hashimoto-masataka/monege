class Public::FavoritesController < ApplicationController

  def create
    household_account = HouseholdAccount.find(params[:household_account_id])
    favorite = current_user.favorites.new(household_account_id:household_account.id)
    favorite.save
    redirect_to household_accounts_path
  end

  def destroy
    household_account = HouseholdAccount.find(params[:household_account_id])
    favorite = current_user.favorites.find_by(household_account_id:household_account.id)
    favorite.destroy
    redirect_to household_accounts_path
  end
end
