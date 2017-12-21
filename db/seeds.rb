# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
  # movies = Movie.create(
  #   [{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# students = []
#
# 1000.times do
#   student = Faker::Name.unique.name
#   students.push(student)
# end
#
# teachers = []
# 10.times do
#   teacher = Faker::TwinPeaks.character
#   teacher1 = Faker::BackToTheFuture.character
#   teacher2 = Faker::Book.author
#   teacher3 = Faker::HarryPotter.character
#   teachers.push(teacher, teacher1, teacher2, teacher3)
# end
#
# admins = []
# 5.times do
#   admin = Faker::ProgrammingLanguage.creator
#   admins.push(admin)
# end

course_array = ["Calculus", "Intro to Mechanical Engineering", "Psychology", "Anatomy and Physiology", "Art History Survey I", "Art History Survey II", "Biology", "Organic Chemisty", "Statistics", "Applied Physics", "Ecology and Evolution", "Biotechnology and Society", "English", "Computer Science", "General Chemisty Lab", "Sociology"]

course_array.each do |ct|
  Course.create(course_title: ct)
end
