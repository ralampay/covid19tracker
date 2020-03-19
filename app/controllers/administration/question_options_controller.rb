module Administration
  class QuestionOptionsController < ApplicationController
    before_action :authenticate_user!
    before_action :authenticate_admin!
    before_action :load_question!

    def new
      @question_option  = QuestionOption.new
    end

    def create
      @question_option          = QuestionOption.new(question_option_params)
      @question_option.question = @question

      if @question_option.save
        redirect_to administration_survey_path(@survey)
      else
        render :new
      end
    end

    def edit
      @question_option  = QuestionOption.find(params[:id])
    end
    
    def update
      @question_option          = QuestionOption.find(params[:id])
      @question_option.question = @question

      if @question_option.update(question_option_params)
        redirect_to administration_survey_path(@survey)
      else
        render :edit
      end
    end

    def destroy
      @question_option  = QuestionOption.find(params[:id])
      @question_option.destroy!

      redirect_to administration_survey_path(@survey)
    end

    def question_option_params
      params.require(:question_option).permit!
    end

    def load_question!
      @question = Question.find(params[:question_id])
      @survey   = @question.survey
    end
  end
end
