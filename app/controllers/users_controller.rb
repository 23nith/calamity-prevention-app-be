class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]

  def index
    if current_user.role == "admin"
      @users = User.all
      render json: @users
    else
      render status: :forbidden
    end
  end

  def show
    render json: @user
  end

  def create
    if current_user.role == "admin"
      @user = User.new(user_params)
      if current_user.role == "admin"
        @user.skip_confirmation!
      end

      if @user.save!
        render json: { 
            status: {code: 200, message: "Admin successfully created user."},
        }
      else
        render json: @user.errors, status: :unprocessable_entity
      end

      if user_params["role"] == "contact_person"
        ContactPerson.create!(user_id: @user.id, area_id: @user.area_id)
      elsif user_params["role"] == "admin"
        Admin.create!(user_id: @user.id)
      end
    else
      render status: :forbidden
    end
  end

  def update
    if current_user.role == "admin"
      @user = User.find(params[:id])
      @user.update(email: user_params[:email])
      @user.confirmed_at = DateTime.now
      @user.skip_confirmation!
      @user.update(password: user_params[:password])
      @user.update(first_name: user_params[:first_name])
      @user.update(last_name: user_params[:last_name])
      @user.update(area_id: user_params[:area_id])
      @user.update(longitude: user_params[:longitude])
      @user.update(latitude: user_params[:latitude])
      @user.update(role: user_params[:role])
      if @user.save!
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    else
      render status: :forbidden
    end
  end

  def destroy
    if current_user.role == "admin"
      @user.destroy
      render json: {
        status: {code: 200, message: 'Delete successful.'},
      }
    else
      render status: :forbidden
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:area_id, :email, :first_name, :last_name, :address, :longitude, :latitude, :role, :password)
    end
end
