class Users::SessionsController < ApplicationController

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to users_my_page_path(user), notice:'guestuserでログインしました'
  end
end
