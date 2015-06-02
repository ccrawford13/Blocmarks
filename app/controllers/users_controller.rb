class UsersController < ApplicationController

  before_action :authorize_user

  def show
    @user = User.find(params[:id])
    @topics = @user.topics
    @bookmarks = @user.bookmarks
    @likes = @user.likes
  end

  def authorize_user
    unless current_user
      redirect_to new_user_session_path
      flash[:error] = "You must be signed in to view this User's Profile"
    end
  end
end