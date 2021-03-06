module Api
  module V1
    class UsersController < ApplicationController
      def resend_confirmation
        user  = User.where(
                  email: params[:email],
                  is_active: nil
                ).first

        if user.present?
          ::Users::ResendConfirmation.new(user: user).execute! 
          render json: { message: "ok" }
        else
          render json: { message: "error" }, status: 400
        end
      end

      def update_group_name
        current_user.update!(group_name: params[:group_name])

        render json: { message: "ok" }
      end

      def update_company
        current_user.update!(company: params[:company])

        render json: { message: "ok" }
      end

      def change_password
        errors = []

        if params[:password].blank?
          errors << "password required"
        end

        if params[:password_confirmation].blank?
          errors << "password_confirmation required"
        end

        if params[:password].present? and params[:password_confirmation].present? and params[:password] != params[:password_confirmation]
          errors << "Passwords do not match"
        end

        if errors.size > 0
          render json: { errors: errors }, status: 400
        else
          current_user.update!(
            password: params[:password],
            password_confirmation: params[:password_confirmation]
          )

          render json: { message: "ok" }
        end
      end

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
