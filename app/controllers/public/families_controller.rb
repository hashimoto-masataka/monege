class Public::FamiliesController < ApplicationController


  def index
    @families = current_user.families
    @family= Family.new
  end

  def edit
    @family= Family.find(params[:id])

  end

  def create
    @family = Family.new(family_params)
    @family.user_id= current_user.id
    @families = current_user.families
    if @family.save
      redirect_to families_path
      flash.now[:notice] = "新規家族を登録しました"
    else
      render :index
    end
  end

  def update
    @family = Family.find(params[:id])
    if @family.update(family_params)
      redirect_to families_path
      flash.now[:notice] = '家族名を変更しました'
    else
      render :edit
    end
  end

  def destroy
    @family = Family.find(params[:id])
    @family.delete
      redirect_to families_path
      flash.now[:notice] = '家族名を削除しました'
  end

  private

  def family_params
    params.require(:family).permit(:family_name)
  end
end
