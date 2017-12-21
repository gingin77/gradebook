class CreateGrades < ActiveRecord::Migration[5.1]
  def change
    create_table :grades do |t|
      t.float :percentage
      t.belongs_to :student, index: true
      t.belongs_to :course, index: true
      t.timestamps
    end
  end
end
