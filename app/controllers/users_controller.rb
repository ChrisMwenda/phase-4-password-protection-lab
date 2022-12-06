class UsersController < ApplicationController
    # create a new user; save their hashed password in the database; save the user's ID in the session hash; and return the user object in the JSON response.
  
    def create 
      user = User.create(user_params)
      if user.valid?
        session[:user_id] = user.id
        render json: user, status: :created
      else
        render json: {errors: user.errors.full_messages}, status: :unprocessable_entity
      end
    end
  
    #If the user is authenticated, return the user object in the JSON response.
  
    def show
      user = User.find_by(id: session[:user_id])
      if user
        render json: user
      else
        render json: { error: "Not authorized" }, status: :unauthorized
      end
    end
  
    private 
    
    def user_params
      params.permit(:username, :password, :password_confirmation)
    end
  end