class PatientsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_active!
  before_action :load_patient, only: [:edit, :update, :destroy, :show]
  before_action :load_values, only: [:new, :create, :edit, :update]

  def index
    @patients = Patient.where(user_id: current_user.id)

    @patients = @patients.order(
                  "updated_at DESC"
                )

    @patients = @patients.page(params[:page]).per(20)
  end

  def show
  end

  def new
    @patient  = Patient.new
  end

  def create
    @patient      = Patient.new(patient_params)
    @patient.user = current_user

    if @patient.save
      redirect_to patient_path(@patient)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @patient.update(patient_params)
      redirect_to patient_path(@patient)
    else
      render :edit
    end
  end

  def destroy
    @patient.destroy!
    redirect_to patients_path
  end

  def load_values
    cmd = FetchRegions.new
    cmd.execute!

    @data = cmd.data
  end

  def load_patient
    @patient  = Patient.where(user_id: current_user.id, id: params[:id]).first

    if @patient.blank?
      redirect_to patients_path
    end
  end

  def patient_params
    params.require(:patient).permit!
  end
end
