class AddStudentsAndCourses < ActiveRecord::Migration[5.1]
  def up
    10.times do |i|
      Student.create(name: Faker::Name.unique.name)
    end
  end

  def down
    Student.delete_all
  end
end
