class TopicsController < ApplicationController
  
  before_action :user_present?, only:[:index, :create, :update, :edit, :destroy]
  before_action :find_topic,  only:[:show, :edit, :update, :destroy]

  def index
    @topics = Topic.all
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = @user.topics.build( topic_params )
    authorize @topic
    @topic.save

    respond_to do |format|
      format.html
      format.js 
    end
  end

  def show
  end

  def edit
    authorize @topic
  end

  def update
    authorize @topic
    @topic.update_attributes( topic_params )

    respond_to do |format|
      format.html
      format.js 
    end
  end

  def destroy
    authorize @topic
    @topic.destroy
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
