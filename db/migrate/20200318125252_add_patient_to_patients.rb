class AddPatientToPatients < ActiveRecord::Migration[5.2]
  def change
    add_reference :patients, :patient, foreign_key: true, type: :uuid
  end
end
