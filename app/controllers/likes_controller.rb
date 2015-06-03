class LikesController < ApplicationController
  respond_to :html, :json

  def create
    @bookmark = Bookmark.find(params[:bookmark_id])
    @like = current_user.likes.build(bookmark: @bookmark)
    @favorite_bookmark = @like.bookmark
    @topic = @favorite_bookmark.topic

    if @like.save
      controlled_redirect(@topic, current_user)
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
      controlled_redirect(@topic, current_user)
      flash[:notice] = "Favorite successfully removed"
    else
      flash[:error] = "There was an error removing your Favorite"
    end
  end

  # If Like is Added or Deleted outside of Topics#show - redirect to User#show
  def controlled_redirect(redirect_object, user) 
    if URI(request.referer).path == user_path(user)
      redirect_to user_path(user)
    else
      redirect_to redirect_object
    end
  end
end
