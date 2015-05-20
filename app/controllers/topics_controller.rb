class TopicsController < ApplicationController
  
  before_action :user_present?, only:[:index, :create]

  def index
    @topics = Topic.all
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = @user.topics.build( topic_params )
    @topic.save

    respond_to do |format|
      format.html
      format.js 
    end
  end

  def show
  end

  def edit
  end

  private

  def user_present?
    if current_user
      @user = current_user
    end
  end

  def topic_params
    params.require(:topic).permit(:title)
  end
end
