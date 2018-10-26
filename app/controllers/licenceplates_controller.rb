# frozen_string_literal: true

class LicenceplatesController < ApplicationController
  before_action :logged_in_user, only: [:new]
  before_action :admin_user,     only: %i[update likes dislikes edit destroy]
  helper_method :sort_column, :sort_direction

  def index
    # @licenceplates = Licenceplate.all
    @licenceplates = Licenceplate.order(sort_column + " " + sort_direction)
  end

  def show
    @licenceplate = Licenceplate.find(params[:id])
  end

  def new
    @licenceplate = Licenceplate.new
  end

  def edit
    @licenceplate = Licenceplate.find(params[:id])
  end

  def update
    @licenceplate = Licenceplate.find(params[:id])

    if @licenceplate.update(licenceplate_params)
      redirect_to licenceplate_path
    else
      render 'edit'
    end
  end

  def create
    @licenceplate = Licenceplate.new(licenceplate_params)
    # Insert a space in the middle if the plate is length == 6
    if @licenceplate.plate.length == 6
      @licenceplate.plate.insert(3, " ")
    end
    if @licenceplate.save
      @licenceplate.plate.upcase!
      redirect_to @licenceplate
    elsif !@licenceplate.save && Licenceplate.exists?(plate: @licenceplate.plate)
      @existingplate = Licenceplate.find_by(plate: @licenceplate.plate)
      redirect_to licenceplate_url(@existingplate)
    elsif !@licenceplate.save
      render 'new'
    else
      render 'new'
    end
  end

  def destroy
    Licenceplate.find(params[:id]).destroy
    flash[:success] = "Licenceplate deleted"
    redirect_to licenceplates_path
  end

  def upvote
    @licenceplate = Licenceplate.find(params[:licenceplate_id])
    if !current_user.nil? && current_user.admin
      # @licenceplate.vote_by voter: current_user, :duplicate => true
      @licenceplate.upvote_from current_user
      redirect_to @licenceplate
    elsif !current_user.nil?
      @licenceplate.upvote_from current_user
      redirect_to @licenceplate
    else
      redirect_to login_url
    end
  end

  def downvote
    @licenceplate = Licenceplate.find(params[:licenceplate_id])
    if !current_user.nil? && current_user.admin
      # @licenceplate.vote_by voter: current_user, :duplicate => true
      @licenceplate.downvote_from current_user
      redirect_to @licenceplate
    elsif !current_user.nil?
      @licenceplate.downvote_from current_user
      redirect_to @licenceplate
    else
      redirect_to login_url
    end
  end

  def likes
    if !current_user.nil? && current_user.admin?
      @licenceplate = Licenceplate.find(params[:licenceplate_id])
      @likes = Licenceplate.find(params[:licenceplate_id]).get_likes
    else
      redirect_to licenceplates_path
    end
  end

  def dislikes
    if !current_user.nil? && current_user.admin?
      @licenceplate = Licenceplate.find(params[:licenceplate_id])
      @dislikes = Licenceplate.find(params[:licenceplate_id]).get_dislikes
    else
      redirect_to licenceplates_path
    end
  end

  def sort_column
    Licenceplate.column_names.include?(params[:sort]) ? params[:sort] : "plate"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  private

  def licenceplate_params
    params.require(:licenceplate).permit(:plate, :province)
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
