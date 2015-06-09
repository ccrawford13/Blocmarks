class BookmarksController < ApplicationController
  
  before_action :find_topic, only:[:create]
  respond_to :html, :json, except:[:index, :new]

  def index
    object = params.key?(:topic_id) ? Topic.find(params[:topic_id]) : User.find(params[:user_id])
    @bookmarks = object.bookmarks
  end

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = @topic.bookmarks.build(bookmark_params)
    @bookmark.user = User.find(current_user.id)
    authorize @bookmark
    if !@bookmark.save
      flash.now[:error] = "Error creating Bookmark. #{@bookmark.errors.full_messages}"
    end
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark
  end

  def update
    @bookmark = Bookmark.find(params[:id]).decorate
    authorize @bookmark
    if !@bookmark.update_attributes(bookmark_params)
      flash.now[:error] = "Error updating Bookmark. #{@bookmark.errors.full_messages}"
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @user = @bookmark.user
    authorize @bookmark
    if @bookmark.destroy
      controlled_redirect(@user)
    else
      flash.now[:error] = "Error deleting Bookmark. #{@bookmark.errors.full_messages}"
    end
  end

  private

  def controlled_redirect(user) 
    if URI(request.referer).path == user_path(user)
      redirect_to user_path(user)
      flash[:notice] = "Bookmark successfully removed."
    end
  end

  def bookmark_params
    params.require(:bookmark).permit(:description, :url)
  end

  def find_topic
    @topic = Topic.find(params[:topic_id])
  end
end
