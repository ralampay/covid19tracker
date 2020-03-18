class AddAccessToIncomeAndAccessToTransportationAndAccessToFoodAndReceivesGovernmentAidToPatients < ActiveRecord::Migration[5.2]
  def change
    add_column :patients, :access_taccess_to_income, :boolean
    add_column :patients, :access_to_transportation, :boolean
    add_column :patients, :access_to_food, :boolean
    add_column :patients, :receives_government_aid, :boolean
  end
end
