module Api
  module V1
    class UsersController < ApplicationController
      def register
        first_name            = params[:first_name]
        last_name             = params[:last_name]
        username              = params[:username]
        email                 = params[:email]
        password              = params[:password]
        password_confirmation = params[:password_confirmation]

        errors  = ::Users::ValidateRegister.new(
                    first_name: first_name,
                    last_name: last_name,
                    username: username,
                    email: email,
                    password: password,
                    password_confirmation: password_confirmation
                  ).execute!

        if errors.size > 0
          render json: { errors: errors }, status: 400
        else
          ::Users::Register.new(
            first_name: first_name,
            last_name: last_name,
            username: username,
            email: email,
            password: password,
            password_confirmation: password_confirmation
          ).execute!

          render json: { message: "ok" }
        end
      end

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
