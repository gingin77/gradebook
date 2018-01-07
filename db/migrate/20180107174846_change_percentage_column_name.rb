class ChangePercentageColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :enrollments, :percentage, :grade
  end
end
