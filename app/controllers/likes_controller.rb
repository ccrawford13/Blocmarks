class LikesController < ApplicationController
  respond_to :html, :json

  def create
    @bookmark = Bookmark.find(params[:bookmark_id])
    @like = current_user.likes.build(bookmark: @bookmark)
    @favorite_bookmark = @like.bookmark
    @topic = @favorite_bookmark.topic

    if @like.save
      redirect_to @topic
      flash[:notice] = "Favorite successfully added"
    else
      flash[:error] = "There was an error creating your Favorite"
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @favorite_bookmark = @like.bookmark
    @topic = @favorite_bookmark.topic
    
    if @like.destroy
      redirect_to @topic
      flash[:notice] = "Favorite successfully removed"
    else
      flash[:error] = "There was an error removing your Favorite"
    end
  end
end
