class AppstoreController < ApplicationController
  # before_action :logged_in_user, only: [:upvote,:downvote]
  def index
    @users = User.all
    @kevin = User.first
  end

  def update
  end

  def upvote
    @kevin = User.first
    if !current_user.nil?
      @kevin.upvote_from current_user
      redirect_to appstore_index_url
    else
      redirect_to login_url
    end
  end

  def downvote
    @kevin = User.first
    if !current_user.nil?
      @kevin.downvote_from current_user
      redirect_to appstore_index_url
    else
      redirect_to login_url
    end
  end
end
