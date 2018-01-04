class LicenceplatesController < ApplicationController
  def index
    @licenceplates = Licenceplate.all
  end

  def show
    @licenceplate = Licenceplate.find(params[:id])
  end

  def new
  end

  def create
    # render plain: params[:licenceplate].inspect
    @licenceplate = Licenceplate.new(licenceplate_params)

    @licenceplate.save
    redirect_to @licenceplate
  end

  private
    def licenceplate_params
      params.require(:licenceplate).permit(:plate, :province, :upvote, :downvote)
    end
end
