module Administration
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :authenticate_admin!

    def index
      @users  = User.all

      @users  = @users.page(params[:page]).per(20)
    end

    def show
      @user = User.find(params[:id])
    end

    def promote
      @user = User.find(params[:user_id])
      @user.update!(role: "ADMIN")

      redirect_to administration_user_path(@user)
    end

    def demote
      @user = User.find(params[:user_id])
      @user.update!(role: "USER")

      redirect_to administration_user_path(@user)
    end
  end
end
