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
  end
end
