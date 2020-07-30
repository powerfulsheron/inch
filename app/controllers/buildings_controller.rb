class BuildingsController < ApplicationController
  protect_from_forgery :except => [:update]
  def index
    @buildings = Building.all
  end

  def import
    Building.import(params[:file])
    redirect_to :action => "index", notice: "Buildings data imported !"
  end

  def update
    building = Building.find_by_reference(params[:reference])
    if building.update(building_params)
      render json: building, status: :ok
    else
      render json: @building.errors, status: :unprocessable_entity
    end
  end
  
  private
    def building_params
      params.require(:building).permit(:address, :zip_code, :city, :country, :manager_name)
    end

end
