class UsersController < ApplicationController
  before_action :require_user!

  def show
    @user = User.includes(member_clubs: :memberships).find(params[:id])
  end
end
