class NeedsController < ApplicationController
  before_action :set_need, only: %i[ show update destroy]

  def index
    @needs = Need.all
    render json: @needs
  end

  def show
    render json: @need
  end

  def create
    @need = Need.new(need_params)

    if @need.save!
      render json: @need, status: :created, location: @need
    else
      render json: @need.errors, status: :unprocessable_entity
    end
  end

  def update
    if @need.update(need_params)
      render json: @need
    else
      render json: @area.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @need.destroy
    render json: {
        status: {code: 200, message: 'Delete successful.'},
      }
  end

  private
    def set_need
      @need = Need.find(params[:id])
    end

    def need_params
      params.require(:need).permit(:calamity_id, :cost, :count, :description)
    end
end
