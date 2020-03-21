class CreateMaterializedViewCountClassifications < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      CREATE MATERIALIZED VIEW mat_view_count_classifications AS
        SELECT
          patients.classification,
          COUNT(*)
        FROM
          patients
        GROUP BY
          patients.classification
    SQL
  end

  def down
    execute <<-SQL
      DROP MATERIALIZED VIEW mat_view_count_classifications
    SQL
  end
end
