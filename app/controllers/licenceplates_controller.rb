class LicenceplatesController < ApplicationController
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
      redirect_to @licenceplate
    else
      render 'edit'
    end

    def upvote
      @licenceplate.increment!(:upvote)
    end

  end

  def create
    @licenceplate = Licenceplate.new(licenceplate_params)

    if @licenceplate.save
      redirect_to @licenceplate
    else
      render 'new'
    end

  end

  def upvote
    @licenceplate = Licenceplate.find(params[:licenceplate_id])
    @licenceplate.increment!(:upvote)
    redirect_to @licenceplate
  end

  def downvote
    @licenceplate = Licenceplate.find(params[:licenceplate_id])
    @licenceplate.increment!(:downvote)
    redirect_to @licenceplate
  end

  private
    def licenceplate_params
      params.require(:licenceplate).permit(:plate, :province, :upvote, :downvote)
    end
end
