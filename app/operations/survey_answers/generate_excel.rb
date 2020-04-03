module SurveyAnswers
  class GenerateExcel
    def initialize(survey:, start_date:, end_date:)
      @survey     = survey
      @start_date = start_date
      @end_date   = end_date
      @p          = Axlsx::Package.new
    end

    def execute!
      @data = ::SurveyAnswers::FetchSummary.new(
                config: {
                  survey_id: @survey.id,
                  start_date_answered: @start_date,
                  end_date_answered: @end_date
                }
              ).execute!
      @p.workbook do |wb|
        wb.add_worksheet do |sheet|
          sheet.add_row ["Start Date", @start_date]
          sheet.add_row ["End Date", @end_date]

          row = []
          @data[:questions].each do |q|
            row << q[:content]
          end

          sheet.add_row row

          @data[:records].each do |r|
            row = []

            r[:answers].each do |a|
              row << a
            end

            sheet.add_row row
          end
        end
      end

      @p
    end
  end
end
