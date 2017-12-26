10.times do |s|
  Teacher.create(name: Faker::TwinPeaks.character)
end

teachers = Teacher.all

COURSE_NAMES = ["Calculus", "Computer Science", "Mechanical Engineering", "Psychology", "Anatomy and Physiology", "Art History Survey I", "Art History Survey II", "Biology", "Organic Chemisty", "Statistics", "Applied Physics", "Ecology and Evolution", "Biotechnology and Society", "English", "Computer Science", "General Chemisty Lab", "Sociology", "Wizardry", "Invisibility", "Quidditch"]

COURSE_NAMES.each do |ct|
  Course.create(
    course_title: ct,
    teacher_id: teachers.sample.id
  )
end

courses = Course.all
norm = Rubystats::NormalDistribution.new(80.0, 14.4)
percentages = 100.times.map { norm.rng.round(3) }

50.times do |s|
  student = Student.create(name: Faker::HarryPotter.character)
  4.times do |g|
    Grade.create(
      :student_id => student.id,
      :course_id => courses.sample.id,
      :percentage => percentages.sample
    )
  end
end

######### User types below have assocatiated passwords #########

test_student = Student.create(name: "Harry Potter")
user_hp = User.create(password: "secret1!", username: "hpotter1", identifiable: test_student)

4.times do |g|
  Grade.create(
    :student_id => test_student.id,
    :course_id => courses.sample.id,
    :percentage => percentages.sample
  )
end

test_teacher = Teacher.create(name: "Minerva McGonagall")
user_teacher = User.create(password: "secret1!", username: "mmcgonagall1", identifiable: test_teacher)

test_teachers_first_course = courses[0]
test_teachers_first_course.teacher_id = test_teacher.id
test_teachers_first_course.save

test_teachers_second_course = courses[1]
test_teachers_second_course.teacher_id = test_teacher.id
test_teachers_second_course.save
