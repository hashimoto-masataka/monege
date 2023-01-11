# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :user_state, only: [:create]

   protected

    def after_sign_in_path_for(resource)
      root_path
    end

    def after_sign_out_path_for(resource)
      new_user_session_path
    end

  # 会員の論理削除のための記述。退会後は、同じアカウントでは利用できない。
  def user_state#退会しているかを判断するメソッド
    @user = User.find_by(email: params[:user][:email])
     #入力されたe-mailから該当するアカウントを取得
    if @user
      if @user.valid_password?(params[:user][:password]) && (@user.is_deleted == true)
        #該当するアカウントのパスワードが一致　かつ　is_deletedがtrueであるか確認
        flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
        redirect_to new_user_registration_path
      else
        flash[:notice] = "項目を入力してください"
      end
    end
  end
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end



end
