class UsersController < ApplicationController
   skip_before_action :authorize, only: [:create]
    def create
        #POST/signup
        user = User.create(user_params)
        if user.valid?
            session[:user_id] = user.id
            render json: user, status: :created
        else
            # binding.pry
            render json: {errors: user.errors.full_messages}, status: :unprocessable_entity
        end
    end 

    def show
        #GET/me
        
        if @current_user
            render json: @current_user
        else
            render json: {errors: "not authorized"}, status: :unauthorized
        end
    end

    private

    def user_params
        params.permit(:username, :password, :image_url, :bio, :password_confirmation, :id)
    end
end
