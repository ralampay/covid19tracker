class CreateEstablishments < ActiveRecord::Migration[5.2]
  def change
    create_table :establishments, id: :uuid do |t|
      t.string :name
      t.string :contact_person
      t.string :address
      t.string :region
      t.string :province
      t.string :city
      t.string :village
      t.string :category
      t.string :contact_number
      t.integer :number_of_people_in_need
      t.decimal :lat
      t.decimal :lng
      t.text :description
      t.string :severity
      t.string :needs

      t.timestamps
    end
  end
end
