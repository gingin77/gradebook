ADMIN_NAMES = ["Albus Dumbledore", "Minerva McGonagall"]

TEACHERS_NAMES = ["Joyce Byers", "Jim Hopper", "Dale Cooper", "Major Garland Briggs", "Dr. Lawrence Jacoby", "Severus Snape", "Sirius Black", "Lord Voldemort", "Rubeus Hagrid", "Gilderoy Lockhart", "Alastor (Mad-Eye) Moody", "Ms. Frizzle", "Mr. Belding", "Professor Annalise Keating", "Nate Lahey", "Frank Delfino"]

COURSE_NAMES = ["Calculus", "Computer Science", "Mechanical Engineering", "Psychology", "Anatomy and Physiology", "Art History Survey I", "Art History Survey II", "Biology", "Organic Chemisty", "Statistics", "Applied Physics", "Ecology and Evolution", "Biotechnology and Society", "English", "Computer Science", "General Chemisty Lab", "Sociology", "Wizardry", "Invisibility", "Quidditch", "Criminal Law", "Civil Defense"]

STUDENT_NAMES = ["Mike Wheeler", "Eleven", "Dustin Henderson", "Lucas Sinclair", "Nancy Wheeler", "Will Byers", "Maxine Mayfield", "Steve Harrington", "Billy Hargrove", "Laura Palmer", "Audrey Horne", "Donna Hayward", "James Hurley", "Shelly Johnson", "Bobby Briggs", "Vincent Crabbe", "Harry Potter", "Ron Weasley", "Hermione Granger", "Draco Malfoy", "Teddy Lupin", "Ernie Macmillan", "Cormac McLaggen", "Graham Montague", "Theodore Nott", "Pansy Parkinson", "Parvati Patil", "Zack Morris", "Kelly Kapowski", "Screech Powers", "A.C. Slater", "Jessie Spano", "Lisa Turtle", "Stacey Carosi", "Brandon Walsh", "Kelly Taylor", "Steve Sanders", "Andrea Zuckerman", "Dylan McKay", "David Silver", "Donna Martin", "Clay Jensen", "Hannah Baker", "Tony Padilla", "Jessica Davis", "Justin Foley", "Bryce Walker", "Alex Standall", "Zach Dempsey", "Tyler Down", "Lainie Jensen", "Courtney Crimsen", "Wes Gibbins", "Connor Walsh", "Rebecca Sutter", "Michaela Pratt", "Asher Millstone", "Oliver Hampton", "Laurel Castillo"]

ADMIN_NAMES.each {|a| Admin.create( name: a )}
admins = Admin.all

TEACHERS_NAMES.each {|t| Teacher.create( name: t )}
teachers = Teacher.all

STUDENT_NAMES.each {|s| Student.create(name: s)}
students = Student.all

users_to_be = teachers + admins + students
users_to_be.each do |u|
  name = u.name
  username = (name[0] + name.split(' ')[name.split.length - 1]).downcase
  User.create(
    password: "secret!",
    username: username,
    identifiable: u
  )
end

COURSE_NAMES.each {|ct| Course.create(course_title: ct, teacher_id: teachers.sample.id)}
courses = Course.all

norm = Rubystats::NormalDistribution.new(80.0, 14.4)
grades = 400.times.map { norm.rng.round(3) }

students.each do |s|
  4.times do |g|
    Enrollment.create(
      :student_id => s.id,
      :course_id => courses.sample.id,
      :grade => grades.sample
    )
  end
end
