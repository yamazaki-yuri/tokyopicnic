class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show edit update]

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:notice] = t('flash_message.update.success', item: User.human_attribute_name(:profile))
      redirect_to profile_path
    else
      flash.now['alert'] = t('flash_message.update.failure', item: User.human_attribute_name(:profile))
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:name, :email, :avatar)
  end
end
