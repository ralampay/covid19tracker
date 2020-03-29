module ApplicationHelper
  def key_questions(survey_id)
    Question.where(is_key: true, survey_id: survey_id)
  end

  def key_options(question_id)
    SurveyQuestionAnswer.where(
      question_id: question_id
    ).pluck(:answer).uniq
  end

  def primary_patients(user, patient)
    patients  = Patient.where(
                  user_id: user.id,
                  is_primary: true
                )

    if !patient.new_record?
      patients  = patients.where.not(id: patient.id)
    end

    patients  = patients.order("last_name ASC")

    patients
  end

  def classification_count_by_city(classification)
    MatViewCityCountClassification.where(
      classification: classification
    ).where("count > 0")
  end
end
