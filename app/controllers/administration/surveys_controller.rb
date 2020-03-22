module Administration
  class SurveysController < ApplicationController
    before_action :authenticate_user!
    before_action :authenticate_admin!

    def index
      @surveys = Survey.all

      @surveys = @surveys.order(
                    "updated_at DESC"
                  )

      @surveys = @surveys.page(params[:page]).per(20)
    end

    def stats
      @survey = Survey.find(params[:survey_id])
    end

    def show
      @survey = Survey.find(params[:id])
    end


    def new
      @survey  = Survey.new
    end

    def create
      @survey  = Survey.new(survey_params)

      if @survey.save
        redirect_to administration_survey_path(@survey)
      else
        render :new
      end
    end

    def edit
      @survey = Survey.find(params[:id])
    end

    def update
      @survey = Survey.find(params[:id])
      
      if @survey.update(survey_params)
        redirect_to administration_survey_path(@survey)
      else
        render :edit
      end
    end

    def destroy
      @survey = Survey.find(params[:id])
      @survey.destroy!
      redirect_to administration_surveys_path
    end

    def survey_params
      params.require(:survey).permit!
    end
  end
end
