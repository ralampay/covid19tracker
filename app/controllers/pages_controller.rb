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
end
