class CreatePatients < ActiveRecord::Migration[5.2]
  def change
    create_table :patients, id: :uuid do |t|
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.string :gender
      t.string :status
      t.string :city
      t.string :barangay
      t.string :address
      t.references :user, foreign_key: true, type: :uuid
      t.string :symptoms
      t.decimal :temperature
      t.text :notes

      t.timestamps
    end
  end
end
