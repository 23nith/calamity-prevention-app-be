class AreasController < ApplicationController

  before_action :set_area, only: %i[ show update destroy ]

  def index
    @areas = Area.all 
    render json: @areas
  end

  def show
    render json: @area
  end

  def create
    if current_user.role == "admin"
      @area = Area.new(area_params)

      if @area.save
        render json: @area, status: :created, location: @area
      else
        render json: @area.errors, status: :unprocessable_entity
      end
    else
      render status: :forbidden
    end
  end

  def update
    if current_user.role == "admin"
      if @area.update(area_params)
        render json: @area
      else
        render json: @area.errors, status: :unprocessable_entity
      end
    else
      render status: :forbidden
    end
  end

  def destroy
    if current_user.role == "admin"
      @area.destroy
      render json: {
        status: {code: 200, message: 'Delete successful.'},
      }
    else
      render status: :forbidden
    end
  end

  private
    def set_area
      @area = Area.find(params[:id])
    end

    def area_params
      params.require(:area).permit(:id, :address, :name, :longitude, :latitude, :radius)
    end

end
