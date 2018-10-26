# frozen_string_literal: true

class AppstoreController < ApplicationController
  before_action :admin_user, only: %i[likes dislikes]

  def index
    @users = User.all
    @kevin = User.first
  end

  def show; end

  def update; end

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

  def likes
    @kevin = User.first
    if !current_user.nil? && current_user.admin?
      @likes = @kevin.get_likes
    else
      redirect_to login_url
    end
  end

  def dislikes
    @kevin = User.first
    if !current_user.nil? && current_user.admin?
      @dislikes = @kevin.get_dislikes
    else
      redirect_to login_url
    end
  end

  private

  # Confirms a logged-in user.
  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = "Please log in."
    redirect_to login_url
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
