class SessionsController < ApplicationController
    skip_before_action :authorize, only: [:create]
    def create
        #POST/login
        user = User.find_by(username: params[:username])
        if user&.authenticate(params[:password])
          session[:user_id] = user.id
          render json: user, status: :created
        else
          render json: { errors: ["User not logged in"] }, status: :unauthorized
        end
    end

    def destroy
        #delete/logout
        if session[:user_id]
        session[:user_id] = nil
        else
            render json: {errors: "not authorized"}, status: :unauthorized
        end
    end


end
