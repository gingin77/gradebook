COURSE_NAMES = ["Calculus", "Computer Science", "Mechanical Engineering", "Psychology", "Anatomy and Physiology", "Art History Survey I", "Art History Survey II", "Biology", "Organic Chemisty", "Statistics", "Applied Physics", "Ecology and Evolution", "Biotechnology and Society", "English", "Computer Science", "General Chemisty Lab", "Sociology", "Wizardy", "Invisibility", "Quidditch"]

COURSE_NAMES.each do |ct|
  Course.create(course_title: ct)
end

courses = Course.all
norm = Rubystats::NormalDistribution.new(80.0, 14.4)
percentages = 100.times.map { norm.rng.round(3) }

10.times do |s|
  student = Student.create(name: Faker::HarryPotter.character)
  4.times do |g|
    Grade.create(
      :student_id => student.id,
      :course_id => courses.sample.id,
      :percentage => percentages.sample
    )
  end
end
