class CreateSurveys < ActiveRecord::Migration[5.2]
  def change
    create_table :surveys, id: :uuid do |t|
      t.string :name

      t.timestamps
    end
  end
end
