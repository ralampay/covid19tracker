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

      def submit_answer
        survey_question_answer  = SurveyQuestionAnswer.find(params[:id])
        answer                  = params[:answer]

        survey_question_answer.update!(answer: answer)

        render json: { message: "ok" }
      end

      def finalize
        survey_answer = SurveyAnswer.find(params[:id])
        answers       = JSON.parse(params[:answers])
        
        answers.each do |a|
          survey_answer.survey_question_answers.where(
            id: a["id"]
          ).first.update!(answer: a["answer"])
        end

        survey_answer.update!(is_final: true, date_submitted: Date.today)

        render json: { message: "ok" }
      end
    end
  end
end
