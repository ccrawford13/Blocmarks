class UsersController < ApplicationController
  decorates_assigned :user
  before_action :authorize_user
  respond_to :html, :json

  def show
    @users = UserDecorator.decorate_collection(User.all)
    @user = UserDecorator.find(params[:id])
    @topics = @user.topics.order(:created_at).page(params[:page]).per(5).decorate
    @bookmarks = @user.bookmarks.order(:created_at).page(params[:page]).per(5).decorate
    @likes = @user.likes.order(:created_at).page(params[:page]).per(5).decorate
  end

  def authorize_user
    unless current_user
      redirect_to new_user_session_path
      flash[:error] = "You must be signed in to view this User's Profile"
    end
  end
end