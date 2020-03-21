module ApplicationHelper
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
