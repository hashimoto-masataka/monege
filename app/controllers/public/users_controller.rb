class Public::UsersController < ApplicationController

  before_action :ensure_guest_user, only: [:edit ,:unsubscribe]
  #ゲストユーザーがカスタマーの編集ページに直接入力しても遷移できないようにする。

  def show
    @user = current_user

  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
       flash[:success] = "登録情報を変更しました"
       redirect_to users_my_page_path(current_user)
    else
       render :edit
    end
  end

  def unsubscribe

  end

  def withdraw
    @user = current_user
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

	private

 def user_params
  	params.require(:user).permit(:name, :email, :job, :age, :annual_income, :prefecture, :is_deleted)

 end


 def ensure_guest_user
    if (current_user.name == "guestuser")&&(current_user.email == 'guest@example.com')
      redirect_to root_path ,notice: 'ゲストユーザーはマイページの編集はできません。'
    end
 end
end
