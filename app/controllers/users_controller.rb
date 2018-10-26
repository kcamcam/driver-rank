# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[edit update destroy likes dislikes]
  before_action :admin_user,     only: %i[destroy index]

  def index
    @users = User.all
  end

  def show
    @user = if current_user.admin?
              User.find(params[:id])
            else
              User.find(current_user[:id])
            end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to Plate Rank homie!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def likes
    if !current_user.nil? && current_user.admin?
      @user = User.find(params[:user_id])
      @likes = User.find(params[:user_id]).find_up_voted_items
    else
      @user = User.find(current_user[:id])
      @likes = current_user.find_up_voted_items
    end
  end

  def dislikes
    if !current_user.nil? && current_user.admin?
      @user = User.find(params[:user_id])
      @dislikes = User.find(params[:user_id]).find_down_voted_items
    else
      @user = User.find(current_user[:id])
      @dislikes = current_user.find_down_voted_items
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  # Before filters

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
