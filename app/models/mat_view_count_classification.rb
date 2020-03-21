class MatViewCountClassification < ActiveRecord::Base
  self.table_name = 'mat_view_count_classifications'

  def readonly?
    true
  end

  def self.refresh
    ActiveRecord::Base.connection.execute('REFRESH MATERIALIZED VIEW mat_view_count_classifications')
  end
end
