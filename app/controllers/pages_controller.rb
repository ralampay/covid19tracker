class PagesController < ApplicationController
  def index
    @patients = Patient.all

    @patients = @patients.order("updated_at DESC")

    @patients = @patients.page(params[:page]).per(20)
  end
end
