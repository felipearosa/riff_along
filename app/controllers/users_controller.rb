class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show]
  def show
    @user = User.find(params[:id])
    @achievements = Achievement.all
    authorize @user
    authorize @achievements
    # @user_lists = List.where(user_id: params[:id])
  end
end
