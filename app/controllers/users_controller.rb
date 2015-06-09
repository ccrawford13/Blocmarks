class UsersController < ApplicationController
  decorates_assigned :user
  before_action :authorize_user

  def show
    @users = UserDecorator.decorate_collection(User.all)
    @user = UserDecorator.find(params[:id])
    @topics = @user.topics.order(:created_at).page(params[:page]).per(4).decorate
    @bookmarks = @user.bookmarks.order(:created_at).page(params[:page]).per(4).decorate
    @likes = @user.likes.order(:created_at).page(params[:page]).per(4).decorate
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  def authorize_user
    unless current_user
      redirect_to new_user_session_path
      flash[:error] = "You must be signed in to view this User's Profile"
    end
  end
end