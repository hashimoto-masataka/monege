class Public::RelationshipsController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:create ,:destroy]

  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  def followings
    user = User.find(params[:user_id])
    @users = user.followings.page(params[:page]).per(7)

  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followers.page(params[:page]).per(7)

  end

  private

  def ensure_guest_user
    if (current_user.name == "guestuser")&&(current_user.email == 'guest@example.com')
      redirect_to root_path ,notice: 'ゲストユーザーは他のユーザーを参考登録できません。'
    end
 end

end
