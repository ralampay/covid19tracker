class EstablishmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_establishment, only: [:edit, :update, :destroy, :show]
  before_action :load_values, only: [:new, :create, :edit, :update]

  def index
    @establishments = Establishment.where(user_id: current_user.id)

    @establishments = @establishments.order(
                  "updated_at DESC"
                )

    @establishments = @establishments.page(params[:page]).per(20)
  end

  def show
  end

  def new
    @establishment  = Establishment.new
  end

  def create
    @establishment      = Establishment.new(establishment_params)
    @establishment.user = current_user

    if @establishment.save
      redirect_to establishment_path(@establishment)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @establishment.update(establishment_params)
      redirect_to establishment_path(@establishment)
    else
      render :edit
    end
  end

  def destroy
    @establishment.destroy!
    redirect_to establishments_path
  end

  def load_values
    cmd = FetchRegions.new
    cmd.execute!

    @data = cmd.data
  end

  def load_establishment
    @establishment  = Establishment.where(user_id: current_user.id, id: params[:id]).first

    if @establishment.blank?
      redirect_to establishments_path
    end
  end

  def establishment_params
    params.require(:establishment).permit!
  end
end
