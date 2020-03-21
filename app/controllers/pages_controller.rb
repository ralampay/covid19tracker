class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:profile]
  def index
    @patients = Patient.all

    @patients = @patients.order("updated_at DESC")

    @patients = @patients.page(params[:page]).per(20)

    @establishments = Establishment.all
  end

  def profile
  end

  def register
  end

  def confirm
    if params[:confirmation_token].blank?
      redirect_to root_path
    end

    @user = User.where(confirmation_token: params[:confirmation_token]).first

    if !@user.present?
      redirect_to root_path(error_message: "user not found")
    elsif @user.is_active
      redirect_to root_path
    else
      @user.update!(
        is_active: true
      )
    end
  end
end
