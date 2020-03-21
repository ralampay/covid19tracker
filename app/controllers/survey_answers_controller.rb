class SurveyAnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_active!
  before_action :load_survey_answer, only: [:destroy, :show]

  def index
    @survey_answers = SurveyAnswer.where(
                        user_id: current_user.id
                      ).order("updated_at DESC")

    @survey_answers = @survey_answers.page(params[:page]).per(20)
  end

  def show
    @survey = @survey_answer.survey
  end

  def destroy
    @survey_answer.destroy!
    redirect_to survey_answers_path
  end

  def load_survey_answer
    @survey_answer  = SurveyAnswer.where(user_id: current_user.id, id: params[:id]).first

    if @survey_answer.blank?
      redirect_to survey_answers_path
    end
  end
end
