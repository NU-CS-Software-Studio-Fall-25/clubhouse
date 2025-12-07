class ProfilesController < ApplicationController
  before_action :require_user!

  def show
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(profile_params)
      redirect_to profile_path, notice: "Profile updated successfully."
    else
      flash.now[:alert] = "Please correct the errors below."
      render :show, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:user).permit(:description, :graduation_year, :major, :avatar)
  end
end
