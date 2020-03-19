module SurveyAnswers
  class Create
    attr_accessor :survey, :user, :survey_answer

    def initialize(survey:, user:)
      self.survey = survey
      self.user   = user
    end

    def execute!
      survey_answer = SurveyAnswer.new(survey: survey, user: user)

      survey.questions.order("priority ASC").each do |q|
        survey_question_answer  = SurveyQuestionAnswer.new(
                                    question: q,
                                    answer: ""
                                  )

        survey_answer.survey_question_answers << survey_question_answer
      end

      survey_answer.save!

      survey_answer
    end
  end
end
