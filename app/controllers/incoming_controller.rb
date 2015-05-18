class IncomingController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create]

  def create

    @user = User.find_by_email(params[:sender])

    @topic = Topic.find_by_title(params[:subject])
    
    @url = params["body-plain"]
  
    # If user does not exist - create valid user -> How do I check to see if exists in db?
    # set required params as email address
    # send mail to newly created user after to update attributes
    if @user.nil?
      @user = User.new(
        first_name:            params[:sender],
        last_name:             params[:sender],
        email:                 params[:sender],
        password:              params[:sender],
        password_confirmation: params[:sender]
      )
      @user.save
    end

    # If topic does not exist - create valid topic
    # set title equal to email[:subject]
    if @topic.nil?
      @topic = @user.topics.build(
        :title => params[:subject]
      )
      @topic.save
    end

    # # Create associated bookmark with existing or new topic instance
    @bookmark = @topic.bookmarks.build(url: @url)
    @bookmark.save
    head 200
  end
end