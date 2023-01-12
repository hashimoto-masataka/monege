class Public::HouseholdsController < ApplicationController

  def index
    @households = Household.all
  end
end
