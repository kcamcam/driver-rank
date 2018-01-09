class LicenceplatesController < ApplicationController
  before_action :logged_in_user, only: [:new]
  before_action :admin_user,     only: [:update]
  def index
    @licenceplates = Licenceplate.all
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
    if @licenceplate.save
      redirect_to @licenceplate
    elsif @licenceplate.plate != "" && Licenceplate.exists?()
        @existingplate = Licenceplate.find_by(plate: @licenceplate.plate)
        redirect_to licenceplate_url(@existingplate)
    else
      render 'new'
    end

  end

  def upvote
    @licenceplate = Licenceplate.find(params[:licenceplate_id])
    # @licenceplate.increment!(:upvote)
    @licenceplate.upvote_from current_user
    redirect_to @licenceplate
  end

  def downvote
    @licenceplate = Licenceplate.find(params[:licenceplate_id])
    # @licenceplate.increment!(:downvote)
    @licenceplate.downvote_from current_user
    redirect_to @licenceplate
  end

  private
    def licenceplate_params
      params.require(:licenceplate).permit(:plate, :province)
    end

    # Before filters

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
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
