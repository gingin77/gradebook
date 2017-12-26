class CreateTeachers < ActiveRecord::Migration[5.1]
  def change
    create_table :teachers do |t|
      t.string :name
      t.timestamps
    end

    add_reference :courses, :teacher, foreign_key: true
  end
end
