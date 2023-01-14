class Public::FavoritesController < ApplicationController

  def create
    household = Household.find(params[:household_id])
    favorite = current_user.favorites.new(household_id:household.id)
    favorite.save
    redirect_to households_path(household)
    # household_account = HouseholdAccount.find(params[:household_account_id])
    # favorite = current_user.favorites.new(household_account_id:household_account.id)
    # favorite.save
    # redirect_to household_account_favorites_path(household_accounts)
  end

  def destroy
    household = Household.find(params[:household_id])
    favorite = current_user.favorites.find_by(household_id:household.id)
    favorite.destroy
    redirect_to households_path

  end
end
