class UsersController < ApplicationController
  
  before_action :if_topic?
  before_action :if_bookmark?

  def show
    @user = User.find(params[:id])
    @topics = @user.topics
  end

  def if_topic?
    if @topic
      @topic = Topic.find(params[:id])
    end
  end

  def if_bookmark?
    if @bookmarks
      @bookmarks = Bookmark.find(params[:id])
    end
  end

end
