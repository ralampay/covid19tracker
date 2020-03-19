module Administration
  class QuestionsController < ApplicationController
    before_action :authenticate_user!
    before_action :authenticate_admin!
    before_action :load_survey!

    def new
      @question = Question.new
    end

    def create
      @question         = Question.new(question_params)
      @question.survey  = @survey

      if @question.save
        redirect_to administration_survey_path(@survey)
      else
        render :new
      end
    end

    def edit
      @question = Question.find(params[:id])
    end
    
    def update
      @question         = Question.find(params[:id])
      @question.survey  = @survey

      if @question.update(question_params)
        redirect_to administration_survey_path(@survey)
      else
        render :edit
      end
    end

    def destroy
      @question = Question.find(params[:id])
      @question.destroy!

      redirect_to administration_survey_path(@survey)
    end

    def question_params
      params.require(:question).permit!
    end

    def load_survey!
      @survey = Survey.find(params[:survey_id])
    end
  end
end
