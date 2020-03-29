module SurveyAnswers
  class FetchStats
    def initialize(config:, kv: [])
      @config               = config
      @survey_id            = @config[:survey_id]
      @start_date_answered  = @config[:start_date_answered]
      @end_date_answered    = @config[:end_date_answered]

      @kv = kv

      @data = {
        records: [],
        num_answers: 0,
        num_respondents: 0
      }

      if @kv.any?
        @kv = @kv.select{ |o|
                o[:val].present?
              }

        if @kv.any?
          @survey_answer_ids  = SurveyQuestionAnswer.where(
                                  "question_id IN (?) AND answer IN (?)",
                                  @kv.map{ |o| o[:key].split("_").last },
                                  @kv.map{ |o| o[:val] }
                                ).pluck(:survey_answer_id).uniq

          ids = @survey_answer_ids.map{ |id| "'#{id}'" }.join(",")

          @additional_query = " AND survey_answers.id IN (#{ids})"
        end
      end
    end

    def execute!

      query = "
        SELECT
          surveys.id AS survey_id,
          survey_answers.date_answered,
          questions.id AS question_id,
          questions.content AS question_content,
          survey_question_answers.answer,
          COUNT(survey_question_answers.answer) AS count
        FROM
          survey_question_answers
        INNER JOIN
          questions
          ON questions.id = survey_question_answers.question_id
        INNER JOIN
          survey_answers
          ON survey_answers.id = survey_question_answers.survey_answer_id AND survey_answers.is_final = 't'
        INNER JOIN
          surveys
          ON surveys.id = survey_answers.survey_id
        WHERE
          surveys.id = '#{@survey_id}' AND date_answered >= '#{@start_date_answered}' AND date_answered <= '#{@end_date_answered}' #{@additional_query if @additional_query.present?}
        GROUP BY
          surveys.id, questions.id, survey_question_answers.answer, survey_answers.date_answered
        ORDER BY
          questions.priority ASC
      "

      result  = ActiveRecord::Base.connection.execute(query).to_a

      result.group_by{ |tx| tx["question_id"] }.each do |question_id, txs|
        @data[:records] << {
          question: {
            id: question_id,
            content: Question.find(question_id).content,
            answers: txs.map{ |t|
              {
                answer: t.fetch("answer"),
                count: t.fetch("count")
              }
            }
          }
        }
      end

      @data
    end
  end
end
