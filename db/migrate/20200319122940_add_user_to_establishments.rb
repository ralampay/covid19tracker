class AddUserToEstablishments < ActiveRecord::Migration[5.2]
  def change
    add_reference :establishments, :user, foreign_key: true, type: :uuid
  end
end
