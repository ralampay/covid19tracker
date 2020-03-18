module Api
  module V1
    class UsersController < ApplicationController
      def login
        email     = params[:email]
        password  = params[:password]

        user  = User.where("lower(email) = ? OR lower(username) = ?", email, email).first

        if user && user.valid_password?(password)
          sign_in(:user, user)
          
          render json: { message: "ok" }
        else
          errors  = {
            full_messages: [
              "user not found"
            ]
          }

          render json: { errors: errors }, status: 400
        end
      end
    end
  end
end
