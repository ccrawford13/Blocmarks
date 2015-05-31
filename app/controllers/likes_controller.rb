class LikesController < ApplicationController
  respond_to :html, :json

  def create
    @bookmark = Bookmark.find(params[:bookmark_id])
    @like = current_user.likes.build(bookmark: @bookmark)
    @favorite_bookmark = @like.bookmark

    if @like.save
      redirect_to user_path(current_user)
      flash[:notice] = "Favorite successfully added"
    else
      flash[:error] = "There was an error creating your Favorite"
    end
  end

  def destroy
    @favorite_bookmark = Bookmark.find(params[:id])
    # @like = current_user.likes.find(params[:id])
    @like = current_user.likes.find(params[:id])
    # @bookmark = like.bookmark
    
    if @like.destroy
      redirect_to user_path(current_user)
      flash[:notice] = "Favorite successfully removed"
    else
      flash[:error] = "There was an error removing your Favorite"
    end
  end
end
