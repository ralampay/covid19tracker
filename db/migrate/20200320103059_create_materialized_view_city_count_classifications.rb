class CreateMaterializedViewCityCountClassifications < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      CREATE MATERIALIZED VIEW mat_view_city_count_classifications AS
        SELECT
          patients.classification,
          patients.city,
          COUNT(*)
        FROM
          patients
        GROUP BY
          patients.classification, patients.city
    SQL
  end

  def down
    execute <<-SQL
      DROP MATERIALIZED VIEW mat_view_city_count_classifications
    SQL
  end
  def change
    create_table :materialized_view_city_count_classifications, id: :uuid do |t|
    end
  end
end
