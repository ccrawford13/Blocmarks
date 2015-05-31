class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @topics = @user.topics
    @bookmarks = @user.bookmarks
    @likes = @user.likes
  end
end
