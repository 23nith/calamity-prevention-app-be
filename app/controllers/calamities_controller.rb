class CalamitiesController < ApplicationController
  before_action :set_calamity, only: %i[ show update destroy ]

  def index
    @calamities = Calamity.all 
    render json: @calamities
  end

  def show
    render json: @calamity
  end

  def create
    if current_user.role == "admin"
      @calamity = Calamity.new(calamity_params)
      if @calamity.save!
        render json: @calamity, status: :created, location: @calamity
      else
        render json: @calamity.errors, status: :unprocessable_entity
      end
    else
      render status: :forbidden
    end
  end

  def update
    if current_user.role == "admin"
      if @calamity.update(calamity_params)
        render json: @calamity
      else
        render json: @calamity.errors, status: :unprocessable_entity
      end
    else
      render status: :forbidden
    end
  end

  def destroy
    if current_user.role == "admin"
      @calamity.destroy
      render json: {
        status: {code: 200, message: 'Delete successful.'},
      }
    else
      render status: :forbidden
    end
  end

  private
    def set_calamity
      @calamity = Calamity.find(params[:id])
    end

    def calamity_params
      params.require(:calamity).permit(:area_id, :estimated_date_from, :estimated_date_to, :description, :calamity_type)
    end
end

