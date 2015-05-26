class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @topics = @user.topics
    @topic = Topic.find(params[:id])
    @bookmarks = Bookmark.find(params[:id])
  end
end
