class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @achievements = Achievement.all
    # @user_lists = List.where(user_id: params[:id])
  end
end
