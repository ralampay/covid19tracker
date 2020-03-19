module Api
  module V1
    class SurveyAnswersController < ApplicationController
      before_action :authenticate_user!

      def create
        survey  = Survey.find(params[:survey_id])

        survey_answer = ::SurveyAnswers::Create.new(
                          user: current_user,
                          survey: survey
                        ).execute!

        render json: { id: survey_answer.id }
      end
    end
  end
end
