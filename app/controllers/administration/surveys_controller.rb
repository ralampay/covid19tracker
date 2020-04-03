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

    def summary
      @survey               = Survey.find(params[:survey_id])
      @start_date_answered  = params[:start_date_answered] || Date.today - 1.week
      @end_date_answered    = params[:end_date_answered] || Date.today

      @data = ::SurveyAnswers::FetchSummary.new(
                config: {
                  survey_id: @survey.id,
                  start_date_answered: @start_date_answered,
                  end_date_answered: @end_date_answered
                }
              ).execute!
    end

    def print
      @survey               = Survey.find(params[:survey_id])
      @start_date_answered  = params[:start_date_answered] || Date.today - 1.week
      @end_date_answered    = params[:end_date_answered] || Date.today

      @data = ::SurveyAnswers::FetchSummary.new(
                config: {
                  survey_id: @survey.id,
                  start_date_answered: @start_date_answered,
                  end_date_answered: @end_date_answered
                }
              ).execute!

      render "print"
    end



    def download_excel
      @survey     = Survey.find(params[:survey_id])
      @start_date = params[:start_date]
      @end_date   = params[:end_date]

      excel = ::SurveyAnswers::GenerateExcel.new(
                survey: @survey,
                start_date: @start_date,
                end_date: @end_date
              ).execute!

      filename = "data.xlsx"

      excel.serialize "#{Rails.root}/tmp/#{filename}"
      send_file "#{Rails.root}/tmp/#{filename}", filename: "#{filename}", type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    end

    def stats
      @survey               = Survey.find(params[:survey_id])
      @start_date_answered  = params[:start_date_answered] || Date.today
      @end_date_answered    = params[:end_date_answered] || Date.today

      @kv   = params.keys.select{ |k|
                k.first(9) == "questions"
              }.map{ |k|
                { key: k, val: params[k] }
              }

      @data = ::SurveyAnswers::FetchStats.new(
                config: {
                  survey_id: @survey.id,
                  start_date_answered: @start_date_answered,
                  end_date_answered: @end_date_answered
                },
                kv: @kv
              ).execute!
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
