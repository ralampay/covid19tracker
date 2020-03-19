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
end
