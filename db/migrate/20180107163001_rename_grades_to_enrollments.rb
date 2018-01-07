class RenameGradesToEnrollments < ActiveRecord::Migration[5.1]
  def change
    rename_table :grades, :enrollments
  end
end
