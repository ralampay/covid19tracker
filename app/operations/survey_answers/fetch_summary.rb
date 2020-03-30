module SurveyAnswers
  class FetchSummary
    def initialize(config:, kv: [])
      @config               = config
      @survey_id            = @config[:survey_id]
      @start_date_answered  = @config[:start_date_answered]
      @end_date_answered    = @config[:end_date_answered]

      @survey         = Survey.find(@survey_id)
      @questions      = @survey.questions.order("priority ASC")
      @survey_answers = SurveyAnswer.where(
                          "survey_id = ? AND date_answered >= ? AND date_answered <= ?",
                          @survey_id,
                          @start_date_answered,
                          @end_date_answered
                        )

      @data = {
        questions: @questions.map{ |q|
          {
            id: q.id,
            content: q.content 
          }
        },
        records: []
      }
    end

    def execute!
      @survey_answers.each do |o|
        @data[:records] << {
          survey_answer_id: o.id,
          answers: o.survey_question_answers.joins(:question).order("questions.priority ASC").map{ |sqa|
            sqa.answer
          }
        }
      end

      @data
    end
  end
end
