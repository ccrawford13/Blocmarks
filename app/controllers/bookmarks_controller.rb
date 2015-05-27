class BookmarksController < ApplicationController
  
  before_action :find_topic, only:[:create]

  def index
    object = params.key?(:topic_id) ? Topic.find(params[:topic_id]) : User.find(params[:user_id])
    @bookmarks = object.bookmarks
  end

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = @topic.bookmarks.build(bookmark_params)
    authorize @bookmark
    @bookmark.save

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
  end

  def edit
  end

  def destroy
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:description, :url)
  end

  def find_topic
    @topic = Topic.find(params[:topic_id])
  end
end
