class TopicsController < ApplicationController
  
  before_action :user_present?, except:[:new]
  before_action :find_topic,  except:[:index, :new, :create]
  respond_to :html, :json, except:[:index, :new, :destroy]

  def index
    @topics = Topic.all
    @topic = Topic.new
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = @user.topics.build(topic_params)
    authorize @topic
    if !@topic.save
      flash.now[:error] = "Error creating Topic. #{@topic.errors.full_messages}"
    end
  end

  def show
    @bookmark = Bookmark.new
    @bookmarks = @topic.bookmarks

    # Trying to find the Bookmark associated with the like
    @favorite_bookmark = Bookmark.find(params[:id])

    # Check whether a like exists -
    if current_user.liked(@favorite_bookmark)
      # If so set it here - 
      @like = current_user.likes.find_by_bookmark_id(@favorite_bookmark.id)
    else
      # If not set it to a new Like object
      @like = Like.new
    end
    
    # @favorite_bookmark = @like.bookmark

  end

  def edit
    authorize @topic
  end

  def update
    authorize @topic
    if !@topic.update_attributes(topic_params)
      flash.now[:error] = "Error updating Topic. #{@topic.errors.full_messages}"
    end
  end

  def destroy
    authorize @topic
    if !@topic.destroy
      flash.now[:error] = "Error deleting Topic. #{@topic.errors.full_messages}"
    else
      redirect_to topics_path
    end
  end

  private

  def user_present?
    if current_user
      @user = current_user
    end
  end

  def find_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:title)
  end
end